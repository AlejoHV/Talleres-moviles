import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import '../../widgets/base_view.dart';

class IsolateView extends StatefulWidget {
  const IsolateView({super.key});

  @override
  State<IsolateView> createState() => _IsolateViewState();
}

class _IsolateViewState extends State<IsolateView> {
  String resultado =
      "Presiona el botón para calcular la suma de velocidades de MotoGP.";
  String tiempoInicio = "";
  String tiempoFin = "";
  String duracion = "";

  // Implementa una función CPU-bound: suma de velocidades de pilotos MotoGP
  Future<void> calcularSumaVelocidades() async {
    final receivePort = ReceivePort();

    print("🟢 [MAIN] Iniciando cálculo en Isolate...");
    setState(() {
      resultado = "Calculando...";
      tiempoInicio = DateTime.now().toString();
      tiempoFin = "";
      duracion = "";
    });

    final start = DateTime.now();

    // Lanza el Isolate y pasa el SendPort principal
    await Isolate.spawn(_tareaSumaVelocidades, receivePort.sendPort);

    // Espera el SendPort del Isolate
    final sendPort = await receivePort.first as SendPort;

    // Crea un canal para recibir la respuesta
    final response = ReceivePort();

    // Datos de ejemplo: velocidades máximas de pilotos MotoGP (km/h)
    final velocidades = [
      {"nombre": "Marc Márquez", "velocidad": 352},
      {"nombre": "Valentino Rossi", "velocidad": 349},
      {"nombre": "Fabio Quartararo", "velocidad": 350},
      {"nombre": "Joan Mir", "velocidad": 347},
      {"nombre": "Francesco Bagnaia", "velocidad": 356},
      {"nombre": "Jorge Martín", "velocidad": 354},
    ];

    // Envía los datos y el puerto de respuesta al Isolate
    sendPort.send([velocidades, response.sendPort]);

    // Espera la respuesta del Isolate
    final result = await response.first as String;

    final end = DateTime.now();
    final diff = end.difference(start);

    print("🔵 [MAIN] Cálculo terminado. Duración: ${diff.inMilliseconds} ms");

    if (!mounted) return;
    setState(() {
      resultado = result;
      tiempoFin = end.toString();
      duracion = "${diff.inMilliseconds} ms";
    });
  }

  // Función que se ejecuta en el Isolate
  static void _tareaSumaVelocidades(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final message in port) {
      print("🟡 [ISOLATE] Recibidos datos, iniciando suma...");
      final List<dynamic> velocidades = message[0] as List<dynamic>;
      final SendPort replyPort = message[1] as SendPort;

      int suma = 0;
      String listaPilotos = "";
      for (var piloto in velocidades) {
        suma += piloto["velocidad"] as int;
        listaPilotos += "${piloto["nombre"]}: ${piloto["velocidad"]} km/h\n";
      }
      final promedio = (suma / velocidades.length).toStringAsFixed(2);

      final resultado =
          "Pilotos y sus velocidades máximas:\n\n"
          "$listaPilotos\n"
          "Suma total de velocidades: $suma km/h\n"
          "Promedio: $promedio km/h";

      print("🟣 [ISOLATE] Suma y promedio calculados, enviando resultado...");
      replyPort.send(resultado);
      port.close();
      Isolate.exit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: "MotoGP - Velocidades",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: Image(
                  image: NetworkImage(
                    'https://resources.motogp.pulselive.com/photo-resources/2025/08/12/0db038b7-46ed-4fed-9a72-75efa4e408b0/DS_03243.jpg?width=1440&height=810',
                  ),
                  width: 250,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                resultado,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              if (tiempoInicio.isNotEmpty)
                Text(
                  "⏱️ Inicio: $tiempoInicio",
                  style: const TextStyle(fontSize: 14),
                ),
              if (tiempoFin.isNotEmpty)
                Text(
                  "🏁 Fin: $tiempoFin",
                  style: const TextStyle(fontSize: 14),
                ),
              if (duracion.isNotEmpty)
                Text(
                  "🕒 Duración: $duracion",
                  style: const TextStyle(fontSize: 14),
                ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: calcularSumaVelocidades,
                icon: const Icon(Icons.speed),
                label: const Text("Calcular suma y promedio"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  minimumSize: const Size(200, 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
