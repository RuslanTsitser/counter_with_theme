import 'package:counter_with_theme/features/home/presentation/home_screen.dart';
import 'package:counter_with_theme/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter extends GoRouter {
  AppRouter()
      : super(
          debugLogDiagnostics: true,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const SplashScreen(),
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        );
}
