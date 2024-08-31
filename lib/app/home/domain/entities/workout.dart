import 'package:magic_workout_app/app/home/data/models/workout_model.dart';

class Workout extends WorkoutModel {
  Workout({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.sets,
  });

  double get averageWeight {
    if (sets.isEmpty) {
      return 0;
    }

    return sets.fold(0.0, (sum, set) => sum + set.weightInKg) / sets.length;
  }
}
