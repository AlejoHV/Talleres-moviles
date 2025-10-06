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
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Jose Alejandro Hernández Vallecilla',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.motorcycle,
                        color: Colors.blueAccent,
                        size: 40,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.directions_car,
                        color: Colors.redAccent,
                        size: 40,
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.directions_bus, color: Colors.green, size: 40),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Image(
                      image: NetworkImage(
                        'https://static.vecteezy.com/system/resources/thumbnails/013/529/416/small_2x/motorcycle-logo-design-and-modern-superbike-silhouette-concept-template-vector.jpg',
                      ),
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '¡Bienvenido al panel de medios de transporte!',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
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
