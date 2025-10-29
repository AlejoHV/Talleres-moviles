import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talleresmoviles/widgets/custom_drawer.dart';

import '../models/auth_evidence.dart';
import '../notifiers/auth_notifier.dart';
import '../state/auth_state.dart';

class EvidenceScreen extends StatelessWidget {
  const EvidenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AuthNotifier>();
    final state = notifier.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Evidencia de Sesión'),
        actions: [
          if (state.status == AuthStatus.authenticated)
            IconButton(
              tooltip: 'Cerrar sesión',
              onPressed: () => notifier.logout(),
              icon: const Icon(Icons.logout),
            ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder<AuthEvidence>(
        future: notifier.loadEvidence(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No se pudo cargar la evidencia.\\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final evidence = snapshot.data;
          if (evidence == null) {
            return const Center(child: Text('Sin información almacenada.'));
          }

          final user = evidence.user;

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Datos almacenados',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _DataRow(
                      label: 'Nombre',
                      value: user?.name ?? 'No disponible',
                    ),
                    _DataRow(
                      label: 'Correo',
                      value: user?.email ?? 'No disponible',
                    ),
                    _DataRow(
                      label: 'Tema',
                      value: evidence.theme ?? 'No definido',
                    ),
                    _DataRow(
                      label: 'Idioma',
                      value: evidence.language ?? 'No definido',
                    ),
                    _DataRow(
                      label: 'Token',
                      value: evidence.tokenPresent ? 'Presente' : 'No almacenado',
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Cerrar sesión y limpiar datos'),
                      onPressed: () async {
                        await notifier.logout();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context)
                            ..clearSnackBars()
                            ..showSnackBar(
                              const SnackBar(content: Text('Datos locales eliminados.')),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
