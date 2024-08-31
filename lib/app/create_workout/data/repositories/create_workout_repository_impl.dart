import 'package:magic_workout_app/app/create_workout/domain/repositories/create_workout_repository.dart';
import 'package:magic_workout_app/app/home/data/models/workout_model.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/local_storage/local_storage_service.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';

class CreateWorkoutRepositoryImpl implements CreateWorkoutRepository {
  @override
  LocalStorageService get localStorageService =>
      serviceLocator.get<LocalStorageService>();

  @override
  Future<Workout> saveWorkout(WorkoutModel workout) async {
    // Introduced this delay to simulate remote fetching.
    await Future.delayed(const Duration(seconds: 1));

    final savedWorkouts = _retrieveSavedWorkouts();

    localStorageService.saveData(
      StorageKey.workouts,
      [...savedWorkouts, workout.toJson()],
    );

    return workout.toEntity();
  }

  @override
  Future<Workout> updateWorkout(WorkoutModel workout) async {
    // Introduced this delay to simulate remote fetching.
    await Future.delayed(const Duration(seconds: 1));

    final workouts = _retrieveSavedWorkouts()
        .map((w) => Map<String, dynamic>.from(w as Map)['id'] == workout.id
            ? w = workout.toJson()
            : w)
        .toList();

    localStorageService.saveData(StorageKey.workouts, workouts);

    return workout.toEntity();
  }

  List<dynamic> _retrieveSavedWorkouts() {
    final savedWorkouts =
        localStorageService.retrieveData(StorageKey.workouts, []);
    if (savedWorkouts == null) {
      throw Exception(
          'No workouts were found when trying to save a new workout.');
    }

    return savedWorkouts;
  }
}
