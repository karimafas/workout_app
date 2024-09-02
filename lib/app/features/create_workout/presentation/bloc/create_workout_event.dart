part of 'create_workout_bloc.dart';

abstract class CreateWorkoutEvent {
  const CreateWorkoutEvent();
}

class CreateWorkout extends CreateWorkoutEvent {
  const CreateWorkout({required this.workout});
  final WorkoutModel workout;
}

class UpdateWorkout extends CreateWorkoutEvent {
  const UpdateWorkout({required this.workout});
  final WorkoutModel workout;
}
