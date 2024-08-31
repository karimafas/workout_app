import 'package:magic_workout_app/app/create_workout/domain/repositories/create_workout_repository.dart';
import 'package:magic_workout_app/app/home/data/models/workout_model.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/usecases/use_case.dart';

class CreateWorkoutUseCase implements UseCase<Workout, WorkoutModel> {
  CreateWorkoutUseCase(this.createWorkoutRepository);

  final CreateWorkoutRepository createWorkoutRepository;

  @override
  Future<Workout> call(WorkoutModel params) async {
    return await createWorkoutRepository.saveWorkout(params);
  }
}
