import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_user.dart';

class AuthLocalStorage {
  AuthLocalStorage({
    required SharedPreferences sharedPreferences,
    FlutterSecureStorage? secureStorage,
  })  : _sharedPreferences = sharedPreferences,
        _secureStorage = secureStorage ?? const FlutterSecureStorage();

  static const _tokenKey = 'auth_token';
  static const _nameKey = 'auth_name';
  static const _emailKey = 'auth_email';
  static const _themeKey = 'auth_theme';
  static const _languageKey = 'auth_language';

  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage;

  Future<void> saveSession({
    required AuthUser user,
    required String token,
    String? theme,
    String? language,
  }) async {
    final themeValue = theme ?? 'light';
    final languageValue = language ?? 'es';

    await Future.wait([
      _sharedPreferences.setString(_nameKey, user.name),
      _sharedPreferences.setString(_emailKey, user.email),
      _sharedPreferences.setString(_themeKey, themeValue),
      _sharedPreferences.setString(_languageKey, languageValue),
      _secureStorage.write(key: _tokenKey, value: token),
    ]);
  }

  Future<AuthUser?> getUser() async {
    final name = _sharedPreferences.getString(_nameKey);
    final email = _sharedPreferences.getString(_emailKey);
    if (name == null || email == null) {
      return null;
    }
    return AuthUser(name: name, email: email);
  }

  Future<String?> getToken() => _secureStorage.read(key: _tokenKey);

  Future<String?> getTheme() async => _sharedPreferences.getString(_themeKey);

  Future<String?> getLanguage() async => _sharedPreferences.getString(_languageKey);

  Future<void> clear() async {
    await Future.wait([
      _sharedPreferences.remove(_nameKey),
      _sharedPreferences.remove(_emailKey),
      _sharedPreferences.remove(_themeKey),
      _sharedPreferences.remove(_languageKey),
      _secureStorage.delete(key: _tokenKey),
    ]);
  }
}
