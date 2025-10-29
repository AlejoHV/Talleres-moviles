import 'auth_user.dart';

class AuthEvidence {
  const AuthEvidence({
    required this.user,
    required this.tokenPresent,
    required this.theme,
    required this.language,
  });

  final AuthUser? user;
  final bool tokenPresent;
  final String? theme;
  final String? language;
}
