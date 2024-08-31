import 'package:json_annotation/json_annotation.dart';
import 'package:magic_workout_app/app/home/data/models/workout_set.dart';

part 'workout.g.dart';

@JsonSerializable(explicitToJson: true)
class Workout {
  Workout({
    required this.name,
    required this.createdAt,
    required this.sets,
  });

  final String name;
  final DateTime createdAt;
  final List<WorkoutSet> sets;
}
