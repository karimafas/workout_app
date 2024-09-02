part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class RetrieveWorkouts extends HomeEvent {
  const RetrieveWorkouts();
}

class DeleteWorkout extends HomeEvent {
  const DeleteWorkout(this.id);

  final String id;
}
