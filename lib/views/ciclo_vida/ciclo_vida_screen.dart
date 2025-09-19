import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../widgets/base_view.dart';

/// !CicloVidaScreen
/// Nos permite entender cómo funciona el ciclo de vida
/// de un StatefulWidget en Flutter.

class CicloVidaScreen extends StatefulWidget {
  const CicloVidaScreen({super.key});

  @override
  State<CicloVidaScreen> createState() => CicloVidaScreenState();
}

class CicloVidaScreenState extends State<CicloVidaScreen> {
  String texto = "REGISTRO 🟢";
  int contador = 0;

  /// Se ejecuta una vez cuando el objeto State es insertado en el árbol de widgets.
  /// Ideal para inicializaciones que solo deben ocurrir una vez.
  @override
  void initState() {
    super.initState();
    print("🟢 initState() -> La pantalla se ha inicializado");
  }

  /// Se ejecuta después de initState y cada vez que cambian las dependencias del widget,
  /// como cuando cambia el InheritedWidget del que depende.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("🟡 didChangeDependencies() -> Tema o dependencias cambiaron");
  }

  /// Se ejecuta cada vez que el widget necesita ser reconstruido,
  /// por ejemplo, después de llamar a setState().
  @override
  Widget build(BuildContext context) {
    print("🔵 build() -> Construyendo la pantalla");
    return BaseView(
      title: "Ciclo de Vida en flutter uceva",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Demostración del ciclo de vida",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            // Elegí Stepper porque es un widget visualmente atractivo y permite mostrar
            // el avance de un proceso, ideal para ilustrar el ciclo de vida y cambios de estado.
            Stepper(
              currentStep: contador,
              onStepContinue: avanzarPaso,
              onStepCancel: retrocederPaso,
              steps: [
                Step(
                  title: const Text('Registro'),
                  content: const Text('Pantalla inicializada (initState)'),
                  isActive: contador >= 0,
                  state: contador > 0 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Evidencia'),
                  content: const Text('Estado actualizado (setState)'),
                  isActive: contador >= 1,
                  state: contador > 1 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Finalizado'),
                  content: const Text('Pantalla destruida (dispose)'),
                  isActive: contador >= 2,
                  state: contador == 2 ? StepState.complete : StepState.indexed,
                ),
              ],
              controlsBuilder: (context, details) {
                return Row(
                  children: [
                    if (contador < 2)
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: const Text('Siguiente'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    if (contador > 0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Anterior'),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Text(
                contador == 0
                    ? "REGISTRO 🟢"
                    : contador == 1
                    ? "EVIDENCIA 🟠"
                    : "FINALIZADO 🔴",
                key: ValueKey(contador),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Avanza al siguiente paso y registra en consola el cambio de estado.
  void avanzarPaso() {
    setState(() {
      if (contador < 2) {
        contador++;
        texto = contador == 1 ? "EVIDENCIA 🟠" : "FINALIZADO 🔴";
        print("🟠 setState() -> Estado actualizado y build() será llamado");
      }
    });
  }

  /// Retrocede al paso anterior.
  void retrocederPaso() {
    setState(() {
      if (contador > 0) {
        contador--;
        texto = contador == 0 ? "REGISTRO 🟢" : "EVIDENCIA 🟠";
        print("🟠 setState() -> Estado actualizado y build() será llamado");
      }
    });
  }

  /// Se ejecuta cuando el objeto State se elimina permanentemente del árbol de widgets.
  /// Ideal para liberar recursos.
  @override
  void dispose() {
    print("🔴 dispose() -> La pantalla se ha destruido");
    super.dispose();
  }
}
