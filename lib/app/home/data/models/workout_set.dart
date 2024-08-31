import 'package:json_annotation/json_annotation.dart';
import 'package:magic_workout_app/app/home/data/enums/exercise.dart';

part 'workout_set.g.dart';

@JsonSerializable()
class WorkoutSet {
  WorkoutSet({
    required this.exercise,
    required this.weightInKg,
    required this.repetitions,
  });
  
  factory WorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetFromJson(json);

  final Exercise exercise;
  final double weightInKg;
  final int repetitions;

  Map<String, dynamic> toJson() => _$WorkoutSetToJson(this);
}
