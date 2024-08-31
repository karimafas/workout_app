import 'package:bloc/bloc.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/app/home/domain/usecases/delete_workout_use_case.dart';
import 'package:magic_workout_app/app/home/domain/usecases/retrieve_workouts_use_case.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';
import 'package:magic_workout_app/core/usecases/use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<RetrieveWorkouts>(_retrieveWorkouts);
    on<DeleteWorkout>(_deleteWorkout);
  }

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
    try {
      await deleteWorkoutUseCase.call(event.id);
    } catch (e) {
      logger.error(e);
      emit(const HomeWorkoutsDeletionError());
    }
  }
}
