part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeWorkoutsRetrieved extends HomeState {
  const HomeWorkoutsRetrieved({required this.workouts});

  final List<Workout> workouts;

  @override
  List<Object?> get props => [workouts];
}

class HomeWorkoutsRetrievalError extends HomeState {
  const HomeWorkoutsRetrievalError();
}

class HomeWorkoutsDeletionError extends HomeState {
  const HomeWorkoutsDeletionError();
}
