// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutSet _$WorkoutSetFromJson(Map<String, dynamic> json) => WorkoutSet(
      exercise: $enumDecode(_$ExerciseEnumMap, json['exercise']),
      weightInKg: (json['weightInKg'] as num).toDouble(),
      repetitions: (json['repetitions'] as num).toInt(),
    );

Map<String, dynamic> _$WorkoutSetToJson(WorkoutSet instance) =>
    <String, dynamic>{
      'exercise': _$ExerciseEnumMap[instance.exercise]!,
      'weightInKg': instance.weightInKg,
      'repetitions': instance.repetitions,
    };

const _$ExerciseEnumMap = {
  Exercise.barbellRow: 'barbellRow',
  Exercise.benchPress: 'benchPress',
  Exercise.shoulderPress: 'shoulderPress',
  Exercise.deadlift: 'deadlift',
  Exercise.squat: 'squat',
};
