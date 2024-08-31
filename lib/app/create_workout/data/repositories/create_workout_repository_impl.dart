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

    // Here, we have to reload all workouts in order to add a new one to the list. This is inevitable due to the fact that we are "mocking" the API behaviour on the frontend.
    final allSavedWorkouts =
        localStorageService.retrieveData(StorageKey.workouts, []);
    if (allSavedWorkouts == null) {
      throw Exception(
          'No workouts were found when trying to save a new workout.');
    }

    localStorageService.saveData(
      StorageKey.workouts,
      [...allSavedWorkouts, workout.toJson()],
    );

    return workout.toEntity();
  }
}
