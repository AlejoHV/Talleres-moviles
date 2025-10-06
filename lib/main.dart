import 'package:flutter/material.dart';
import 'package:talleresmoviles/routes/app_router.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      title: 'TALLER 3',
      routerConfig: appRouter,
    );
  }
}
