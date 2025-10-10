import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

/// Modelo simple para un personaje de Marvel
class MarvelCharacter {
  final int id;
  final String name;
  final String description;
  final String thumbnailUrl;

  MarvelCharacter({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
  });

  factory MarvelCharacter.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];
    final thumbUrl = thumbnail != null
        ? "${thumbnail['path']}.${thumbnail['extension']}".replaceAll(
            'http://',
            'https://',
          )
        : '';
    return MarvelCharacter(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      thumbnailUrl: thumbUrl,
    );
  }

  /// Función para generar el hash MD5 requerido por la API de Marvel
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}

enum MarvelStatus { loading, success, error }

class MarvelService {
  // Reemplaza estos valores con tus credenciales de la API de Marvel
  static const String _baseUrl = 'https://gateway.marvel.com/v1/public';
  static const String _publicKey = '293a13e1a3fccdf7dc0afbf70c58942b';
  static const String _privateKey = '32988552ea1be74ca7aceb1d593afa797d9b2614';
  static String _ts = DateTime.now().millisecondsSinceEpoch.toString();
  static String _hash = generateMd5(_ts + _privateKey + _publicKey);

  MarvelStatus status = MarvelStatus.loading;
  String errorMessage = '';

  /// Obtiene la lista de personajes de Marvel
  Future<List<MarvelCharacter>> getCharacters() async {
    status = MarvelStatus.loading;
    errorMessage = '';
    final url =
        '$_baseUrl/characters?ts=$_ts&apikey=$_publicKey&hash=$_hash&limit=20';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['data']['results'] as List;
        status = MarvelStatus.success;
        return results.map((json) => MarvelCharacter.fromJson(json)).toList();
      } else {
        status = MarvelStatus.error;
        errorMessage = 'Error: ${response.statusCode}';
        return [];
      }
    } catch (e) {
      status = MarvelStatus.error;
      errorMessage = 'Excepción: $e';
      return [];
    }
  }

  /// Obtiene el detalle de un personaje por su [characterId]
  Future<MarvelCharacter?> getCharacterDetail(int characterId) async {
    status = MarvelStatus.loading;
    errorMessage = '';
    final url =
        '$_baseUrl/characters/$characterId?ts=$_ts&apikey=$_publicKey&hash=$_hash';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['data']['results'] as List;
        if (results.isNotEmpty) {
          status = MarvelStatus.success;
          return MarvelCharacter.fromJson(results[0]);
        } else {
          status = MarvelStatus.error;
          errorMessage = 'No se encontró el personaje';
          return null;
        }
      } else {
        status = MarvelStatus.error;
        errorMessage = 'Error: ${response.statusCode}';
        return null;
      }
    } catch (e) {
      status = MarvelStatus.error;
      errorMessage = 'Excepción: $e';
      return null;
    }
  }
}

String generateMd5(String s) {
  return md5.convert(utf8.encode(s)).toString();
}

class CharacterListScreen extends StatelessWidget {
  final MarvelService _marvelService = MarvelService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personajes de Marvel')),
      body: FutureBuilder<List<MarvelCharacter>>(
        future: _marvelService.getCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final characters = snapshot.data!;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  title: Text(character.name),
                  subtitle: Text(character.description),
                  leading: Image.network(character.thumbnailUrl),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CharacterDetailScreen(characterId: character.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CharacterDetailScreen extends StatelessWidget {
  final int characterId;
  final MarvelService _marvelService = MarvelService();

  CharacterDetailScreen({required this.characterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle del Personaje')),
      body: FutureBuilder<MarvelCharacter?>(
        future: _marvelService.getCharacterDetail(characterId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final character = snapshot.data;
            if (character != null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Image.network(character.thumbnailUrl),
                    SizedBox(height: 8),
                    Text(character.description, style: TextStyle(fontSize: 16)),
                  ],
                ),
              );
            } else {
              return Center(child: Text('Personaje no encontrado'));
            }
          }
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: CharacterListScreen(),
    );
  }
}
/*
void main() {
  runApp(MyApp());
}
*/