import 'package:flutter/foundation.dart';

import '../models/auth_evidence.dart';
import '../repositories/auth_repository.dart';
import '../state/auth_state.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;
  AuthState _state = AuthState.idle;

  AuthState get state => _state;

  Future<void> initialize() async {
    _setState(const AuthState(status: AuthStatus.loading));
    try {
      final user = await _repository.getStoredUser();
      if (user != null) {
        _setState(AuthState(status: AuthStatus.authenticated, user: user));
      } else {
        _setState(const AuthState(status: AuthStatus.idle));
      }
    } catch (error) {
      _setState(
        AuthState(status: AuthStatus.error, errorMessage: error.toString()),
      );
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _setState(const AuthState(status: AuthStatus.loading));
    try {
      await _repository.register(name: name, email: email, password: password);
      await login(email: email, password: password);
    } catch (error) {
      _setState(
        AuthState(status: AuthStatus.error, errorMessage: error.toString()),
      );
    }
  }

  Future<void> login({required String email, required String password}) async {
    _setState(const AuthState(status: AuthStatus.loading));
    try {
      final user = await _repository.login(email: email, password: password);
      _setState(AuthState(status: AuthStatus.authenticated, user: user));
    } catch (error) {
      _setState(
        AuthState(status: AuthStatus.error, errorMessage: error.toString()),
      );
    }
  }

  Future<AuthEvidence> loadEvidence() {
    return _repository.loadEvidence();
  }

  Future<void> logout() async {
    try {
      await _repository.logout();
      _setState(const AuthState(status: AuthStatus.idle));
    } catch (error) {
      _setState(
        AuthState(status: AuthStatus.error, errorMessage: error.toString()),
      );
    }
  }

  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }
}
