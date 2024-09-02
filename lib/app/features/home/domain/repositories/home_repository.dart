import 'package:magic_workout_app/app/features/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/local_storage/local_storage_service.dart';

abstract class HomeRepository {
  LocalStorageService get localStorageService;

  Future<List<Workout>> retrieveWorkouts();
  Future<void> deleteWorkout(String id);
}
