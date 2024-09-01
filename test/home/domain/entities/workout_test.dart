import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/app/home/data/enums/exercise.dart';
import 'package:magic_workout_app/app/home/data/models/workout_set.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';

void main() {
  test('Workout should calculate average weight correctly', () {
    final workout = Workout(
      id: 'test-uuid',
      name: 'Name',
      createdAt: DateTime.now(),
      sets: [
        WorkoutSet(
          exercise: Exercise.barbellRow,
          weightInKg: 10,
          repetitions: 1,
        ),
        WorkoutSet(
          exercise: Exercise.barbellRow,
          weightInKg: 20,
          repetitions: 1,
        ),
        WorkoutSet(
          exercise: Exercise.barbellRow,
          weightInKg: 50,
          repetitions: 1,
        ),
      ],
    );

    expect(workout.averageWeight.toStringAsFixed(2), equals('26.67'));
  });

  test('Workout should format date correctly', () {
    final workout = Workout(
      id: 'test-uuid',
      name: 'Name',
      createdAt: DateTime.parse('2024-08-31'),
      sets: [],
    );

    expect('Created on ${workout.creationDateFormatted}',
        equals('Created on 31 Aug 2024'));
  });
}
