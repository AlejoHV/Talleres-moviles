import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../notifiers/auth_notifier.dart';
import '../state/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isRegisterMode = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _isRegisterMode = !_isRegisterMode;
    });
  }

  Future<void> _submit(AuthNotifier notifier) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    try {
      if (_isRegisterMode) {
        final name = _nameController.text.trim();
        await notifier.register(name: name, email: email, password: password);
      } else {
        await notifier.login(email: email, password: password);
      }

      if (mounted && notifier.state.status == AuthStatus.authenticated) {
        context.go('/auth/evidence');
      }
    } catch (_) {
      // El notifier ya maneja el error, no hacer nada extra aquí.
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AuthNotifier>();
    final state = notifier.state;
    final isLoading = state.status == AuthStatus.loading;
    final textTheme = Theme.of(context).textTheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.status == AuthStatus.error && state.errorMessage != null) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(_isRegisterMode ? 'Registro' : 'Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _isRegisterMode ? 'Crea tu cuenta' : 'Bienvenido de nuevo',
                      style: textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    if (_isRegisterMode)
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingresa un nombre';
                          }
                          return null;
                        },
                      ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Ingresa un correo';
                        }
                        if (!value.contains('@')) {
                          return 'Correo inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Ingresa una contraseña';
                        }
                        if (value.trim().length < 6) {
                          return 'Mínimo 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: isLoading ? null : () => _submit(notifier),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(_isRegisterMode ? 'Registrarse' : 'Iniciar sesión'),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: isLoading ? null : _toggleMode,
                      child: Text(
                        _isRegisterMode
                            ? '¿Ya tienes cuenta? Inicia sesión'
                            : '¿No tienes cuenta? Regístrate',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
