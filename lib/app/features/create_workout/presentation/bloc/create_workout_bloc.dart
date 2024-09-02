import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_workout_app/app/features/create_workout/domain/usecases/create_workout_use_case.dart';
import 'package:magic_workout_app/app/features/create_workout/domain/usecases/update_workout_use_case.dart';
import 'package:magic_workout_app/app/features/home/data/models/workout_model.dart';
import 'package:magic_workout_app/app/features/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';

part 'create_workout_event.dart';
part 'create_workout_state.dart';

class CreateWorkoutBloc extends Bloc<CreateWorkoutEvent, CreateWorkoutState> {
  CreateWorkoutBloc() : super(const CreateWorkoutInitial()) {
    on<CreateWorkout>(_createWorkout);
    on<UpdateWorkout>(_updateWorkout);
  }

  CreateWorkoutUseCase get createWorkoutUseCase =>
      serviceLocator.get<CreateWorkoutUseCase>();
  UpdateWorkoutUseCase get updateWorkoutUseCase =>
      serviceLocator.get<UpdateWorkoutUseCase>();

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

  Future<void> _updateWorkout(
      UpdateWorkout event, Emitter<CreateWorkoutState> emit) async {
    try {
      emit(const CreateWorkoutLoading());
      final updatedWorkout = await updateWorkoutUseCase.call(event.workout);
      emit(UpdateWorkoutSuccess(updatedWorkout: updatedWorkout));
    } catch (e) {
      emit(const UpdateWorkoutFailure());
    }
  }
}
