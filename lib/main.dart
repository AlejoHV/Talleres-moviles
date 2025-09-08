import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hola, Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 9, 12, 221),
        ),
      ),
      home: const MyHomePage(title: 'Hola, Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late String _title;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            Padding(padding: const EdgeInsets.all(8.0)),
            const Text(
              'Jose Alejandro Hernandez Vallecilla',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text('Has presionado el botón esta cantidad de veces:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10), // Espacio entre el texto y los botones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Incrementar',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 10), // Espacio entre los botones
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  tooltip: 'Decrementar',
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRSflWzyL6s9thLVMa0oSMbqtlNMQYHNdUPw&s',
                  width: 120,
                  height: 110,
                ),
                const SizedBox(width: 10), // Espacio entre las imágenes
                Image.asset(
                  'assets/images/dev_movil.jpg',
                  width: 120,
                  height: 110,
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              onPressed: () {
                setState(() {
                  _title = (_title == 'Hola, Flutter')
                      ? '¡Título cambiado!'
                      : 'Hola, Flutter';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Título actualizado')),
                );
              },
              child: const Text(
                'Cambiar título',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Stack(
              children: <Widget>[
                Image.asset(
                  "assets/images/mobile.jpg",
                  width: 170,
                  height: 170,
                ),
                Container(
                  color: Colors.black.withOpacity(0.8),
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.only(top: 120, left: 0),
                  width: 170,
                  height: 30,
                  child: const Text(
                    'Desarrollo Móvil',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Center(
              child: SizedBox(
                height: 150,
                width: 250,
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE3F2FD), // Fondo azul claro
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.phone_android, color: Colors.blue),
                        title: Text('Dispositivo Móvil'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E9), // Fondo verde claro
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.computer, color: Colors.green),
                        title: Text('Computadora'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF3E5F5), // Fondo morado claro
                        border: Border.all(color: Colors.purple, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.code, color: Colors.purple),
                        title: Text('Software'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
