import 'package:go_router/go_router.dart';
import 'package:magic_workout_app/app/home/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
