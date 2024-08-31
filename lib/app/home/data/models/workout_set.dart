import 'package:json_annotation/json_annotation.dart';
import 'package:magic_workout_app/app/home/data/enums/exercise.dart';

part 'workout_set.g.dart';

@JsonSerializable()
class WorkoutSet {
  WorkoutSet({
    required this.exercise,
    required this.weight,
    required this.repetitions,
  });

  final Exercise exercise;
  final double weight;
  final int repetitions;
}
