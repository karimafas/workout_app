part of 'create_workout_bloc.dart';

abstract class CreateWorkoutState {
  const CreateWorkoutState();
}

class CreateWorkoutInitial extends CreateWorkoutState {
  const CreateWorkoutInitial();
}

class CreateWorkoutLoading extends CreateWorkoutState {
  const CreateWorkoutLoading();
}

class CreateWorkoutSuccess extends CreateWorkoutState {
  const CreateWorkoutSuccess();
}

class CreateWorkoutFailure extends CreateWorkoutState {
  const CreateWorkoutFailure();
}
