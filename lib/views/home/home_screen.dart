import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel Principal')),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Jose Alejandro Hernández Vallecilla',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print('¡Botón presionado!');
                },
                child: const Text('Presióname'),
              ),
              const SizedBox(width: 10),
              const Image(
                image: NetworkImage(
                  'https://static.vecteezy.com/system/resources/thumbnails/013/529/416/small_2x/motorcycle-logo-design-and-modern-superbike-silhouette-concept-template-vector.jpg',
                ),
                width: 200,
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
