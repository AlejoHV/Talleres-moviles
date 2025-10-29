import '../models/auth_evidence.dart';
import '../models/auth_user.dart';
import '../services/auth_api_service.dart';
import '../storage/auth_local_storage.dart';

class AuthRepository {
  AuthRepository({
    required AuthApiService apiService,
    required AuthLocalStorage localStorage,
  })  : _apiService = apiService,
        _localStorage = localStorage;

  final AuthApiService _apiService;
  final AuthLocalStorage _localStorage;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) {
    return _apiService.register(name: name, email: email, password: password);
  }

  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final session = await _apiService.login(email: email, password: password);
    await _localStorage.saveSession(user: session.user, token: session.token);
    return session.user;
  }

  Future<AuthUser?> getStoredUser() => _localStorage.getUser();

  Future<String?> getStoredToken() => _localStorage.getToken();

  Future<AuthEvidence> loadEvidence() async {
    final user = await _localStorage.getUser();
    final token = await _localStorage.getToken();
    final theme = await _localStorage.getTheme();
    final language = await _localStorage.getLanguage();

    return AuthEvidence(
      user: user,
      tokenPresent: token != null && token.isNotEmpty,
      theme: theme,
      language: language,
    );
  }

  Future<void> logout() => _localStorage.clear();
}
