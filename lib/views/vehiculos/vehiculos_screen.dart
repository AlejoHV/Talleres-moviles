import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class VehiculosScreen extends StatelessWidget {
  const VehiculosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vehículos'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.motorcycle), text: 'Motos'),
              Tab(icon: Icon(Icons.directions_car), text: 'Carros'),
              Tab(icon: Icon(Icons.directions_bus), text: 'Buses'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Listado de Motos')),
            Center(child: Text('Listado de Carros')),
            Center(child: Text('Listado de Buses')),
          ],
        ),
      ),
    );
  }
}
