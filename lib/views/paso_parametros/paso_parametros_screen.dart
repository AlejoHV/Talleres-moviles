import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talleresmoviles/widgets/custom_drawer.dart';

/// !PasoParametrosScreen - Pantalla de Paso de Parámetros
/// es una vista/screen que permite ingresar un valor
/// y enviarlo a otra vista (DetalleScreen) usando diferentes metodos de navegación.
///
/// Metodos de navegación disponibles:
/// *- go: Reemplaza toda la navegación anterior.
/// *- push: Agrega una nueva pantalla encima de la actual.
/// *- replace: Reemplaza la pantalla actual en la pila de navegación.

class PasoParametrosScreen extends StatefulWidget {
  const PasoParametrosScreen({super.key});

  @override
  State<PasoParametrosScreen> createState() => PasoParametrosScreenState();
}

class PasoParametrosScreenState extends State<PasoParametrosScreen> {
  /// Controlador para capturar el texto ingresado en el TextField
  /// *se utiliza textEditingController para poder capturar el valor del campo de texto
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose(); // Liberamos la memoria del controlador
    // el metodo super.dispose() se encarga de liberar la memoria de los recursos utilizados por el widget
    super.dispose();
  }

  /// !goToDetalle
  /// recibe el tipo de navegación (go, push, replace)
  /// y redirige a la pantalla de detalle con el valor ingresado.
  void goToDetalle(String metodo) {
    String valor = controller.text; // Capturamos el valor del campo de texto

    if (valor.isEmpty) return; // Si el campo está vacio, no hacemos nada

    switch (metodo) {
      case 'go':
        context.go('/detalle/$valor/$metodo');
        break;
      case 'push':
        context.push('/detalle/$valor/$metodo');
        break;
      case 'replace':
        context.replace('/detalle/$valor/$metodo');
        break;
    }
  }

  @override
  // *build es un metodo que retorna un widget
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paso de Parámetros')),
      drawer: const CustomDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.input, size: 60, color: Colors.blueAccent),
                  const SizedBox(height: 16),
                  const Text(
                    'Ingrese un valor para enviarlo a la pantalla de detalle usando diferentes métodos de navegación.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Ingrese un valor',
                      prefixIcon: const Icon(Icons.edit),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => goToDetalle('go'),
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Go'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(90, 45),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => goToDetalle('push'),
                        icon: const Icon(Icons.add),
                        label: const Text('Push'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(90, 45),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => goToDetalle('replace'),
                        icon: const Icon(Icons.swap_horiz),
                        label: const Text('Replace'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(90, 45),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
