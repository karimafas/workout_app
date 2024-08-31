import 'package:go_router/go_router.dart';
import 'package:magic_workout_app/app/home/presentation/screens/home_screen.dart';
import 'package:magic_workout_app/core/router/app_route.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoute.homeScreen.path,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
