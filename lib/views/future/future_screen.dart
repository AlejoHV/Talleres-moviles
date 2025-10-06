import 'dart:async';
import 'package:flutter/material.dart';

import '../../widgets/base_view.dart';

class Piloto {
  final String nombre;
  final String fotografiaUrl;
  Piloto(this.nombre, this.fotografiaUrl);
}

String _mensaje = "Cargando…";
bool _hayError = false;

class FutureView extends StatefulWidget {
  const FutureView({super.key});

  @override
  State<FutureView> createState() => _FutureViewState();
}

class _FutureViewState extends State<FutureView> {
  List<Piloto> _pilotos = []; // declarar una lista.

  @override
  // !inicializa el estado
  void initState() {
    super.initState();
    obtenerDatos(); // carga al iniciar
  }

  // !Funcion que simula una carga de datos
  //*espera 2 segundos antes de cargar los datos, esto simula una carga de datos.
  Future<List<Piloto>> cargarPilotos() async {
    //future.delayed() simula una carga de datos
    await Future.delayed(const Duration(seconds: 2));
    return [
      Piloto(
        'Marc Márquez',
        'https://cdn-7.motorsport.com/images/mgl/0ZR74Db0/s800/marc-marquez-ducati-team.jpg',
      ),
      Piloto(
        'Valentino Rossi',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Valentino_Rossi_2017.jpg/960px-Valentino_Rossi_2017.jpg',
      ),
      Piloto(
        'Álex Marquez',
        'https://cdn-3.motorsport.com/images/mgl/68yG3880/s800/alex-marquez-gresini-racing.jpg',
      ),
      Piloto(
        'Jorge Lorenzo',
        'https://fotografias.antena3.com/clipping/cmsimages01/2023/01/02/FF62AE68-9D5A-4C0E-A12E-6275922CDA97/jorge-lorenzo-concursante-tercera-edicion-desafio_103.jpg?crop=1440,1080,x242,y0&width=1200&height=900&optimize=low&format=webply',
      ),
      Piloto(
        'Francisco Bagnaia',
        'https://cdn-4.motorsport.com/images/mgl/6zQ53NPY/s800/francesco-bagnaia-ducati-team.jpg',
      ),
      Piloto(
        'Jorge Martin',
        'https://cdn-9.motorsport.com/images/mgl/0k7WE580/s8/jorge-martin-aprilia-racing.jpg',
      ),
      Piloto(
        'Pedro Acosta',
        'https://fotografias.lasexta.com/clipping/cmsimages01/2025/08/15/ED9701C5-C64F-4038-A9BF-7E00D549856E/pedro-acosta_160.jpg?crop=5649,3178,x0,y0&width=544&height=306&optimize=low&format=webply',
      ),
      Piloto(
        'Fabio Quartararo',
        'https://cdn-3.motorsport.com/images/mgl/0oOz9qb0/s8/fabio-quartararo-yamaha-factor.jpg',
      ),
      Piloto(
        'Marco Bezzecchi',
        'https://cdn-8.motorsport.com/images/mgl/0rGB5N72/s8/marco-bezzecchi-aprilia-racing.jpg',
      ),
      Piloto(
        'Johann Zarco',
        'https://cdn-3.motorsport.com/images/mgl/2Gz8QOr0/s8/johann-zarco-team-lcr-honda.jpg',
      ),
      //throw Exception("Simulación de error"); // Descomentar esta línea para simular un error
    ];
  }

  // !Funcion que obtiene los datos
  // *carga los datos y los asigna a la lista _pilotos
  Future<void> obtenerDatos() async {
    print("🔵 ANTES de la carga de pilotos"); // Antes de la carga
    setState(() {
      _mensaje = "Cargando…";
      _hayError = false;
    });
    try {
      print("🟡 DURANTE la carga de pilotos"); // Durante la carga
      final datos = await cargarPilotos();
      if (!mounted) return;
      setState(() {
        _pilotos = datos;
        _mensaje = "¡Éxito!";
        _hayError = false;
      });
      print("🟢 DESPUÉS de la carga de pilotos (éxito)"); // Después de la carga
    } catch (e) {
      setState(() {
        _mensaje = "Error al cargar los pilotos";
        _hayError = true;
      });
      print("🔴 DESPUÉS de la carga de pilotos (error)"); // Después de la carga
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Pilotos - MotoGP',
      body: _pilotos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_hayError) const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(_mensaje, style: const TextStyle(fontSize: 18)),
                  if (_hayError)
                    ElevatedButton(
                      onPressed: obtenerDatos,
                      child: const Text("Reintentar"),
                    ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: _pilotos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final piloto = _pilotos[index];
                  return Card(
                    //color: const Color.fromARGB(255, 87, 194, 180),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            piloto.fotografiaUrl,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 60),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          piloto.nombre,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
