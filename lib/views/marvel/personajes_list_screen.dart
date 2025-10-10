import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/marvel_service.dart';

class PersonajesListScreen extends StatefulWidget {
  const PersonajesListScreen({super.key});

  @override
  State<PersonajesListScreen> createState() => _PersonajesListScreenState();
}

class _PersonajesListScreenState extends State<PersonajesListScreen> {
  final MarvelService _service = MarvelService();
  List<MarvelCharacter> _personajes = [];
  MarvelStatus _status = MarvelStatus.loading;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchPersonajes();
  }

  Future<void> _fetchPersonajes() async {
    setState(() {
      _status = MarvelStatus.loading;
      _error = '';
    });
    final personajes = await _service.getCharacters();
    setState(() {
      _status = _service.status;
      _personajes = personajes;
      _error = _service.errorMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personajes Marvel')),
      body: Builder(
        builder: (context) {
          if (_status == MarvelStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_status == MarvelStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    _error.isNotEmpty ? _error : 'Ocurrió un error.',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _fetchPersonajes,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }
          if (_personajes.isEmpty) {
            return const Center(child: Text('No se encontraron personajes.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            itemCount: _personajes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final personaje = _personajes[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  leading: personaje.thumbnailUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            personaje.thumbnailUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 40),
                          ),
                        )
                      : const Icon(Icons.person, size: 40),
                  title: Text(
                    personaje.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: personaje.description.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            personaje.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        )
                      : const Text(
                          'Sin descripción',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.grey,
                  ),
                  onTap: () =>
                      context.push('/detalle_personaje', extra: personaje),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
