import 'package:go_router/go_router.dart';
import 'package:talleresmoviles/auth/notifiers/auth_notifier.dart';
import 'package:talleresmoviles/auth/state/auth_state.dart';
import 'package:talleresmoviles/auth/views/evidence_screen.dart';
import 'package:talleresmoviles/auth/views/login_screen.dart';
import 'package:talleresmoviles/services/marvel_service.dart';
import 'package:talleresmoviles/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:talleresmoviles/views/cronometro/timer_screen.dart';
import 'package:talleresmoviles/views/future/future_screen.dart';
import 'package:talleresmoviles/views/isolate/isolate_screen.dart';
import 'package:talleresmoviles/views/marvel/personajes_detail_screen.dart';
import 'package:talleresmoviles/views/marvel/personajes_list_screen.dart';
import 'package:talleresmoviles/views/paso_parametros/detalle_screen.dart';
import 'package:talleresmoviles/views/paso_parametros/paso_parametros_screen.dart';
import 'package:talleresmoviles/views/tabbar_widget/vehiculos_screen.dart';

import '../views/home/home_screen.dart';

class GoRouterWrapper {
  GoRouterWrapper({required this.notifier})
      : router = GoRouter(
          initialLocation: '/auth/login',
          refreshListenable: notifier,
          redirect: (context, state) {
            final status = notifier.state.status;
            final isAuthenticated = status == AuthStatus.authenticated;
            final isLoggingIn = state.uri.path == '/auth/login';

            if (!isAuthenticated) {
              return isLoggingIn ? null : '/auth/login';
            }

            if (isAuthenticated && isLoggingIn) {
              return '/';
            }

            return null;
          },
          routes: [
            GoRoute(
              path: '/auth/login',
              name: 'login',
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/auth/evidence',
              name: 'evidence',
              builder: (context, state) => const EvidenceScreen(),
            ),
            GoRoute(
              path: '/paso_parametros',
              name: 'paso_parametros',
              builder: (context, state) => const PasoParametrosScreen(),
            ),
            GoRoute(
              path: '/detalle/:parametro/:metodo',
              builder: (context, state) {
                final parametro = state.pathParameters['parametro']!;
                final metodo = state.pathParameters['metodo']!;
                return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
              },
            ),
            GoRoute(
              path: '/ciclo_vida',
              builder: (context, state) => const CicloVidaScreen(),
            ),
            GoRoute(
              path: '/vehiculos',
              name: 'vehiculos',
              builder: (context, state) => const VehiculosScreen(),
            ),
            GoRoute(
              path: '/future',
              name: 'future',
              builder: (context, state) => const FutureView(),
            ),
            GoRoute(
              path: '/cronometro',
              name: 'cronometro',
              builder: (context, state) => const TimerScreen(),
            ),
            GoRoute(
              path: '/isolate',
              name: 'isolate',
              builder: (context, state) => const IsolateView(),
            ),
            GoRoute(
              path: '/marvel',
              name: 'marvel',
              builder: (context, state) => const PersonajesListScreen(),
            ),
            GoRoute(
              path: '/detalle_personaje',
              name: 'detalle_personaje',
              builder: (context, state) {
                final personaje = state.extra as MarvelCharacter;
                return PersonajesDetailScreen(personaje: personaje);
              },
            ),
          ],
        );

  final AuthNotifier notifier;
  final GoRouter router;
}
