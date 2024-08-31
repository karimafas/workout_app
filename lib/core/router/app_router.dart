import 'package:go_router/go_router.dart';
import 'package:magic_workout_app/app/create_workout/presentation/screens/create_workout_screen.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/app/home/presentation/screens/home_screen.dart';
import 'package:magic_workout_app/app/workout_detail/presentation/screens/workout_detail_screen.dart';
import 'package:magic_workout_app/core/router/app_route.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoute.home.path,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoute.createWorkout.path,
      builder: (context, state) {
        final extra = state.extra as ({
          CreateWorkoutScreenType screenType,
          Workout? workoutToEdit
        });
        return CreateWorkoutScreen(
          screenType: extra.screenType,
          workoutToEdit: extra.workoutToEdit,
        );
      },
    ),
    GoRoute(
      path: AppRoute.workoutDetail.path,
      builder: (context, state) => WorkoutDetailScreen(
        workout: state.extra as Workout,
      ),
    ),
  ],
);
