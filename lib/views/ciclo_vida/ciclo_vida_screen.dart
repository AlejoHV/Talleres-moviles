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
            Text(texto, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: actualizarTexto,
              child: const Text("Actualizar Texto"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 116, 250, 116),
                minimumSize: const Size(90, 45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Se llama cuando queremos actualizar el estado del widget.
  /// Provoca que build() se ejecute de nuevo.
  void actualizarTexto() {
    setState(() {
      texto = "EVIDENCIA 🟠";
      print("🟠 setState() -> Estado actualizado y build() será llamado");
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
