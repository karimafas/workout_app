import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_workout_app/app/create_workout/domain/usecases/create_workout_use_case.dart';
import 'package:magic_workout_app/app/home/data/models/workout_model.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';

part 'create_workout_event.dart';
part 'create_workout_state.dart';

class CreateWorkoutBloc extends Bloc<CreateWorkoutEvent, CreateWorkoutState> {
  CreateWorkoutBloc() : super(const CreateWorkoutInitial()) {
    on<CreateWorkout>(_createWorkout);
  }

  CreateWorkoutUseCase get createWorkoutUseCase =>
      serviceLocator.get<CreateWorkoutUseCase>();

  Future<void> _createWorkout(
      CreateWorkout event, Emitter<CreateWorkoutState> emit) async {
    try {
      emit(const CreateWorkoutLoading());
      await createWorkoutUseCase.call(event.workout);
      emit(const CreateWorkoutSuccess());
    } catch (e) {
      emit(const CreateWorkoutFailure());
    }
  }
}
