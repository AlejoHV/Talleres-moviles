import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/notifiers/auth_notifier.dart';
import 'auth/repositories/auth_repository.dart';
import 'auth/services/auth_api_service.dart';
import 'auth/storage/auth_local_storage.dart';
import 'routes/app_router.dart';
import 'themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthRepository _authRepository;
  late final AuthNotifier _authNotifier;
  late final GoRouterWrapper _routerWrapper;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository(
      apiService: AuthApiService(),
      localStorage: AuthLocalStorage(sharedPreferences: widget.sharedPreferences),
    );
    _authNotifier = AuthNotifier(repository: _authRepository);
    _authNotifier.initialize();
    _routerWrapper = GoRouterWrapper(notifier: _authNotifier);
  }

  @override
  void dispose() {
    _authNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthNotifier>.value(
      value: _authNotifier,
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        title: 'TALLER 1',
        routerConfig: _routerWrapper.router,
      ),
    );
  }
}
