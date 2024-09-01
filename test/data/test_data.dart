import 'package:magic_workout_app/app/home/data/enums/exercise.dart';
import 'package:magic_workout_app/app/home/data/models/workout_set.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';

final mockWorkout = Workout(
  id: 'test-uuid',
  name: 'Test Workout',
  createdAt: DateTime.now(),
  sets: [
    WorkoutSet(
      exercise: Exercise.barbellRow,
      weightInKg: 10,
      repetitions: 2,
    )
  ],
);
