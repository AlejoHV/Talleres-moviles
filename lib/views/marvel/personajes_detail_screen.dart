import 'package:flutter/material.dart';
import '../../services/marvel_service.dart';

class PersonajesDetailScreen extends StatelessWidget {
  final MarvelCharacter personaje;

  const PersonajesDetailScreen({super.key, required this.personaje});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personaje.name),
        backgroundColor: Colors.red.shade900,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (personaje.thumbnailUrl.isNotEmpty)
                Hero(
                  tag: personaje.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      personaje.thumbnailUrl,
                      width: 240,
                      height: 240,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                ),
              const SizedBox(height: 28),
              Text(
                personaje.name,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.red.shade100),
                ),
                child: Text(
                  personaje.description.isNotEmpty
                      ? personaje.description
                      : 'Sin descripción disponible.',
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shield, color: Colors.redAccent, size: 32),
                  SizedBox(width: 12),
                  Text(
                    'Marvel Universe',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
