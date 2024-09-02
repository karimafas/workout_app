import 'package:magic_workout_app/app/features/home/data/models/workout_model.dart';
import 'package:magic_workout_app/app/features/home/domain/entities/workout.dart';
import 'package:magic_workout_app/app/features/home/domain/repositories/home_repository.dart';
import 'package:magic_workout_app/core/local_storage/local_storage_service.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  LocalStorageService get localStorageService =>
      serviceLocator.get<LocalStorageService>();

  @override
  Future<List<Workout>> retrieveWorkouts() async {
    // Introduced this delay to simulate remote fetching.
    await Future.delayed(const Duration(milliseconds: 600));

    final workouts = localStorageService.retrieveData(StorageKey.workouts, []);

    if (workouts == null) {
      throw Exception(
        'Unexpected null value returned when retrieving saved workouts.',
      );
    }

    return workouts.map((w) {
      w['sets'] = (w['sets'] as List<dynamic>)
          .map((s) => Map<String, dynamic>.from(s as Map))
          .toList();
      return WorkoutModel.fromJson(Map<String, dynamic>.from(w as Map))
          .toEntity();
    }).toList();
  }

  @override
  Future<void> deleteWorkout(String id) async {
    // Introduced this delay to simulate remote fetching.
    await Future.delayed(const Duration(milliseconds: 600));

    final workouts = localStorageService.retrieveData(StorageKey.workouts, []);

    if (workouts == null || workouts.isEmpty) {
      return;
    }

    workouts.removeWhere((w) => w['id'] as String == id);

    localStorageService.saveData(StorageKey.workouts, workouts);
  }
}
