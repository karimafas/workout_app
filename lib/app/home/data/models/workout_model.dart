import 'package:json_annotation/json_annotation.dart';
import 'package:magic_workout_app/app/home/data/models/workout_set.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';
import 'package:uuid/uuid.dart';

part 'workout_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkoutModel {
  WorkoutModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.sets,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutModelFromJson(json);

  factory WorkoutModel.fromEntity(Workout entity) => WorkoutModel(
      id: serviceLocator.get<Uuid>().v4(),
      name: entity.name,
      createdAt: entity.createdAt,
      sets: entity.sets);

  final String id;
  final String name;
  final DateTime createdAt;
  final List<WorkoutSet> sets;

  Map<String, dynamic> toJson() => _$WorkoutModelToJson(this);

  Workout toEntity() =>
      Workout(id: id, name: name, createdAt: createdAt, sets: sets);
}
