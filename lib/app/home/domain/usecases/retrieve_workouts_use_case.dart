import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/app/home/domain/repositories/home_repository.dart';
import 'package:magic_workout_app/core/usecases/use_case.dart';

class RetrieveWorkoutsUseCase implements UseCase<List<Workout>, NoParams> {
  RetrieveWorkoutsUseCase(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<List<Workout>> call(NoParams params) async {
    return await homeRepository.retrieveWorkouts();
  }
}
