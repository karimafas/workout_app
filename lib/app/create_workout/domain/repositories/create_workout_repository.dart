import 'package:magic_workout_app/app/home/data/models/workout_model.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/local_storage/local_storage_service.dart';

abstract class CreateWorkoutRepository {
  LocalStorageService get localStorageService;

  Future<Workout> saveWorkout(WorkoutModel workout);
  Future<Workout> updateWorkout(WorkoutModel workout);
}
