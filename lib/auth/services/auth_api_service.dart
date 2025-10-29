import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth_session.dart';

class AuthApiException implements Exception {
  AuthApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'AuthApiException(statusCode: $statusCode, message: $message)';
}

class AuthApiService {
  AuthApiService({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  static const String _baseUrl = 'https://parking.visiontic.com.co';
  final http.Client _httpClient;

  Uri _buildUri(String path) => Uri.parse('$_baseUrl$path');

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _httpClient.post(
      _buildUri('/api/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode != 201) {
      throw _mapError(
        response,
        defaultMessage: 'No fue posible registrar el usuario',
      );
    }
  }

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final response = await _httpClient.post(
      _buildUri('/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw _mapError(response, defaultMessage: 'Credenciales inválidas');
    }

    final Map<String, dynamic> jsonBody = _decodeResponse(response);
    return AuthSession.fromJson(jsonBody);
  }

  AuthApiException _mapError(
    http.Response response, {
    required String defaultMessage,
  }) {
    try {
      final Map<String, dynamic> decoded = _decodeResponse(response);
      final message = decoded['message'] ?? decoded['error'] ?? defaultMessage;
      return AuthApiException(
        message.toString(),
        statusCode: response.statusCode,
      );
    } catch (_) {
      return AuthApiException(defaultMessage, statusCode: response.statusCode);
    }
  }

  Map<String, dynamic> _decodeResponse(http.Response response) {
    if (response.body.isEmpty) {
      return <String, dynamic>{};
    }
    final dynamic decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    return <String, dynamic>{};
  }

  void dispose() {
    _httpClient.close();
  }
}
