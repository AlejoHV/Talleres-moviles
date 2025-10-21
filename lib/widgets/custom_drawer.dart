import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      width: 280,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withOpacity(0.95),
              colorScheme.primary.withOpacity(0.85),
              Colors.white,
            ],
            stops: const [0.0, 0.15, 0.15],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primary,
                    colorScheme.primary.withOpacity(0.8),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Icon(
                      Icons.menu_open_rounded,
                      color: Colors.white.withOpacity(0.3),
                      size: 80,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Menú Principal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Navegación de la App',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            //!Items del menú

            //!INICIO
            _buildMenuItem(
              context: context,
              icon: Icons.home_rounded,
              title: 'Inicio',
              route: '/',
            ),

            //!VEHICULOS
            _buildMenuItem(
              context: context,
              icon: Icons.motorcycle_rounded,
              title: 'Vehículos',
              route: '/vehiculos',
            ),

            //!PASO DE PARAMETROS
            _buildMenuItem(
              context: context,
              icon: Icons.input_rounded,
              title: 'Paso de Parámetros',
              route: '/paso_parametros',
            ),

            //!CICLO DE VIDA
            _buildMenuItem(
              context: context,
              icon: Icons.loop_rounded,
              title: 'Ciclo de Vida',
              route: '/ciclo_vida',
            ),

            //!FUTURE
            _buildMenuItem(
              context: context,
              icon: Icons.flag_circle_rounded,
              title: 'Future',
              route: '/future',
            ),

            //!TIMER
            _buildMenuItem(
              context: context,
              icon: Icons.timer_rounded,
              title: 'Cronómetro',
              route: '/cronometro',
            ),

            //!ISOLATE
            _buildMenuItem(
              context: context,
              icon: Icons.memory_rounded,
              title: 'Isolate',
              route: '/isolate',
            ),

            //!MARVEL
            _buildMenuItem(
              context: context,
              icon: Icons.person_rounded,
              title: 'API Marvel',
              route: '/marvel',
            ),

            const SizedBox(height: 20),

            // Footer decorativo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.withOpacity(0.3),
                      Colors.grey.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.grey.withOpacity(0.6),
          size: 20,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        visualDensity: const VisualDensity(vertical: -2),
        onTap: () {
          if (route == '/vehiculos' || route == '/marvel') {
            context.push(route);
          } else {
            context.go(route);
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}
