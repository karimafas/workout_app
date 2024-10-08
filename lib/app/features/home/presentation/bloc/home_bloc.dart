import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:magic_workout_app/app/features/home/domain/entities/workout.dart';
import 'package:magic_workout_app/app/features/home/domain/usecases/delete_workout_use_case.dart';
import 'package:magic_workout_app/app/features/home/domain/usecases/retrieve_workouts_use_case.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';
import 'package:magic_workout_app/core/usecases/use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({this.homeState}) : super(homeState ?? const HomeInitial()) {
    on<RetrieveWorkouts>(_retrieveWorkouts);
    on<DeleteWorkout>(_deleteWorkout);
  }

  @visibleForTesting
  final HomeState? homeState;

  RetrieveWorkoutsUseCase get retrieveWorkoutsUseCase =>
      serviceLocator.get<RetrieveWorkoutsUseCase>();
  DeleteWorkoutUseCase get deleteWorkoutUseCase =>
      serviceLocator.get<DeleteWorkoutUseCase>();

  Future<void> _retrieveWorkouts(
      RetrieveWorkouts event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());

    try {
      emit(
        HomeWorkoutsRetrieved(
          workouts: await retrieveWorkoutsUseCase.call(NoParams()),
        ),
      );
    } catch (e) {
      logger.error(e);
      emit(const HomeWorkoutsRetrievalError());
    }
  }

  Future<void> _deleteWorkout(
      DeleteWorkout event, Emitter<HomeState> emit) async {
    if (state is! HomeWorkoutsRetrieved) {
      return;
    }

    final workouts = (state as HomeWorkoutsRetrieved).workouts;
    emit(HomeWorkoutsRetrieved(
        workouts: [...workouts].where((w) => w.id != event.id).toList()));

    try {
      await deleteWorkoutUseCase.call(event.id);
    } catch (e) {
      logger.error(e);
      emit(const HomeWorkoutsDeletionError());
      emit(HomeWorkoutsRetrieved(workouts: workouts));
    }
  }
}
