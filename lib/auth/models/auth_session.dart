import 'auth_user.dart';

class AuthSession {
  const AuthSession({
    required this.token,
    required this.user,
  });

  final String token;
  final AuthUser user;

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    final rawToken = json['access_token'] ?? json['token'];
    final userJson = json['user'] ?? json['usuario'] ?? json['data'];
    if (rawToken is! String || rawToken.isEmpty) {
      throw const FormatException('Token inválido en la respuesta del servidor');
    }
    if (userJson is! Map<String, dynamic>) {
      throw const FormatException('Usuario inválido en la respuesta del servidor');
    }
    return AuthSession(
      token: rawToken,
      user: AuthUser.fromJson(userJson),
    );
  }
}
