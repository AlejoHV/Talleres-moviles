class AuthUser {
  const AuthUser({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      name: (json['name'] ?? json['nombre'] ?? '') as String,
      email: (json['email'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
