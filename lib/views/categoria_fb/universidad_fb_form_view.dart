import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../auth/models/universidad_fb.dart';
import '../../services/universidad_service.dart';

class UniversidadFbFormView extends StatefulWidget {
  final String? id;

  const UniversidadFbFormView({super.key, this.id});

  @override
  State<UniversidadFbFormView> createState() => _UniversidadFbFormViewState();
}

class _UniversidadFbFormViewState extends State<UniversidadFbFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nitController = TextEditingController();
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _paginaWebController = TextEditingController();
  bool _camposInicializados = false;

  Future<void> _launchURL(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir la URL')),
        );
      }
    }
  }

  Future<void> _guardar({String? id}) async {
    if (_formKey.currentState!.validate()) {
      try {
        final universidad = UniversidadFb(
          id: id ?? '',
          nit: _nitController.text.trim(),
          nombre: _nombreController.text.trim(),
          direccion: _direccionController.text.trim(),
          telefono: _telefonoController.text.trim(),
          paginaWeb: _paginaWebController.text.trim(),
        );

        if (widget.id == null) {
          await UniversidadService.addUniversidad(universidad);
        } else {
          await UniversidadService.updateUniversidad(universidad);
        }

        if (mounted) {
          final colorScheme = Theme.of(context).colorScheme;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.id == null
                    ? 'Universidad creada exitosamente'
                    : 'Universidad actualizada exitosamente',
              ),
              backgroundColor: colorScheme.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          final colorScheme = Theme.of(context).colorScheme;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al guardar: $e'),
              backgroundColor: colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

  void _inicializarCampos(UniversidadFb universidad) {
    if (_camposInicializados) return;
    _nitController.text = universidad.nit;
    _nombreController.text = universidad.nombre;
    _direccionController.text = universidad.direccion;
    _telefonoController.text = universidad.telefono;
    _paginaWebController.text = universidad.paginaWeb;
    _camposInicializados = true;
  }

  @override
  void dispose() {
    _nitController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _paginaWebController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool esNuevo = widget.id == null;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(esNuevo ? 'Nueva Universidad' : 'Editar Universidad'),
      ),
      body: esNuevo
          ? _buildFormulario(context, id: null)
          : StreamBuilder<UniversidadFb?>(
              stream: UniversidadService.watchUniversidadById(widget.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 60,
                          color: colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error al cargar universidad',
                          style: TextStyle(
                            fontSize: 18,
                            color: colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${snapshot.error}',
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        FilledButton.tonal(
                          onPressed: () => context.pop(),
                          child: const Text('Volver'),
                        ),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_off_outlined,
                          size: 60,
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Universidad no encontrada',
                          style: TextStyle(
                            fontSize: 18,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 24),
                        FilledButton.tonal(
                          onPressed: () => context.pop(),
                          child: const Text('Volver'),
                        ),
                      ],
                    ),
                  );
                }

                final universidad = snapshot.data!;
                _inicializarCampos(universidad);
                return _buildFormulario(context, id: universidad.id);
              },
            ),
    );
  }

  Widget _buildFormulario(BuildContext context, {required String? id}) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    // Determinar el ancho máximo según el tamaño del dispositivo
    final double maxWidth = screenWidth > 1200
        ? 800 // Desktop grande
        : screenWidth > 800
        ? 600 // Tablet/Desktop pequeño
        : double.infinity; // Móvil

    // Padding adaptativo
    final double horizontalPadding = screenWidth > 600 ? 24 : 16;
    final double cardPadding = screenWidth > 600 ? 24 : 16;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card con el formulario
                Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainerLowest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(cardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información básica',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nitController,
                          decoration: InputDecoration(
                            labelText: 'NIT',
                            hintText: 'Ingrese el NIT de la universidad',
                            prefixIcon: const Icon(Icons.numbers, size: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          style: const TextStyle(fontSize: 15),
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'El NIT es requerido';
                            }
                            if (value.trim().length < 3) {
                              return 'El NIT debe tener al menos 3 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nombreController,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            hintText: 'Ingrese el nombre de la universidad',
                            prefixIcon: const Icon(Icons.school, size: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          style: const TextStyle(fontSize: 15),
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'El nombre es requerido';
                            }
                            if (value.trim().length < 3) {
                              return 'El nombre debe tener al menos 3 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _direccionController,
                          decoration: InputDecoration(
                            labelText: 'Dirección',
                            hintText: 'Ingrese la dirección de la universidad',
                            prefixIcon: const Icon(Icons.location_on, size: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            alignLabelWithHint: true,
                          ),
                          style: const TextStyle(fontSize: 15),
                          maxLines: 2,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'La dirección es requerida';
                            }
                            if (value.trim().length < 10) {
                              return 'La dirección debe tener al menos 10 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _telefonoController,
                          decoration: InputDecoration(
                            labelText: 'Teléfono',
                            hintText: 'Ingrese el teléfono de la universidad',
                            prefixIcon: const Icon(Icons.phone, size: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          style: const TextStyle(fontSize: 15),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'El teléfono es requerido';
                            }
                            if (value.trim().length < 8) {
                              return 'El teléfono debe tener al menos 8 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _paginaWebController,
                          decoration: InputDecoration(
                            labelText: 'Página Web',
                            hintText: 'https://ejemplo.com',
                            prefixIcon: const Icon(Icons.link, size: 20),
                            suffixIcon: _paginaWebController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.open_in_browser,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      final url = _paginaWebController.text;
                                      if (url.isNotEmpty) {
                                        _launchURL(url);
                                      }
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(
                                  context,
                                ).colorScheme.outline.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          style: const TextStyle(fontSize: 15),
                          keyboardType: TextInputType.url,
                          onChanged: (value) => setState(() {}),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'La página web es requerida';
                            }

                            // Validar formato de URL
                            final urlPattern =
                                r'^(https?|http):\/\/[^\s/\$.?#].[^\s]*\.[^\s]{2,}';
                            if (!RegExp(
                              urlPattern,
                              caseSensitive: false,
                            ).hasMatch(value)) {
                              return 'Ingrese una URL válida (ej: https://ejemplo.com)';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Botones de acción
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed: () => _guardar(id: id),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Guardar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Cancelar'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
