import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/local_storage/local_storage_service.dart';
import 'package:magic_workout_app/core/models/repository_result.dart';

abstract class HomeRepository {
  LocalStorageService get localStorageService;

  Future<RepositoryResult<List<Workout>>> retrieveWorkouts();
}
