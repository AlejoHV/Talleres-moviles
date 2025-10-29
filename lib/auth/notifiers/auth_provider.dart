import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/auth_repository.dart';
import '../services/auth_api_service.dart';
import '../storage/auth_local_storage.dart';
import 'auth_notifier.dart';

class AuthProvider extends StatelessWidget {
  const AuthProvider({
    super.key,
    required this.child,
    required this.sharedPreferences,
  });

  final Widget child;
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final repository = AuthRepository(
      apiService: AuthApiService(),
      localStorage: AuthLocalStorage(sharedPreferences: sharedPreferences),
    );

    return ChangeNotifierProvider<AuthNotifier>(
      create: (_) => AuthNotifier(repository: repository)..initialize(),
      child: child,
    );
  }
}
