part of 'home_bloc.dart';

abstract class HomeState {
  const HomeState();
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
}

class HomeWorkoutsRetrievalError extends HomeState {
  const HomeWorkoutsRetrievalError();
}
