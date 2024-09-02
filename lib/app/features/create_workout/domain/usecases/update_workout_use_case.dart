import 'package:magic_workout_app/app/features/create_workout/domain/repositories/create_workout_repository.dart';
import 'package:magic_workout_app/app/features/home/data/models/workout_model.dart';
import 'package:magic_workout_app/app/features/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/usecases/use_case.dart';

class UpdateWorkoutUseCase implements UseCase<Workout, WorkoutModel> {
  UpdateWorkoutUseCase(this.createWorkoutRepository);

  final CreateWorkoutRepository createWorkoutRepository;

  @override
  Future<Workout> call(WorkoutModel params) async {
    return await createWorkoutRepository.updateWorkout(params);
  }
}
