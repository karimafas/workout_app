import 'package:magic_workout_app/app/home/data/models/workout_model.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/app/home/domain/repositories/home_repository.dart';
import 'package:magic_workout_app/core/exceptions/workout_exceptions.dart';
import 'package:magic_workout_app/core/local_storage/local_storage_service.dart';
import 'package:magic_workout_app/core/models/repository_result.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  LocalStorageService get localStorageService =>
      serviceLocator.get<LocalStorageService>();

  @override
  Future<RepositoryResult<List<Workout>>> retrieveWorkouts() async {
    try {
      // Wait 2 seconds to simulate remote fetching.
      await Future.delayed(const Duration(seconds: 2));

      final workouts =
          localStorageService.retrieveData(StorageKey.workouts, []);

      if (workouts == null) {
        throw Exception(
          'Unexpected null value returned when retrieving saved workouts.',
        );
      }

      return RepositoryResult(
        result:
            workouts.map((w) => WorkoutModel.fromJson(w).toEntity()).toList(),
      );
    } catch (e) {
      return RepositoryResult(
        exception: WorkoutRetrievalException(
          'Could not retrieve workouts, $e',
        ),
      );
    }
  }
}
