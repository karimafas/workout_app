import 'package:json_annotation/json_annotation.dart';
import 'package:magic_workout_app/app/home/data/models/workout_set.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';

part 'workout_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkoutModel {
  WorkoutModel({
    required this.name,
    required this.createdAt,
    required this.sets,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutModelFromJson(json);

  factory WorkoutModel.fromEntity(Workout entity) => WorkoutModel(
      name: entity.name, createdAt: entity.createdAt, sets: entity.sets);

  final String name;
  final DateTime createdAt;
  final List<WorkoutSet> sets;

  Map<String, dynamic> toJson() => _$WorkoutModelToJson(this);

  Workout toEntity() => Workout(name: name, createdAt: createdAt, sets: sets);
}
