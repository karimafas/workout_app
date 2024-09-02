import 'package:magic_workout_app/app/features/home/domain/repositories/home_repository.dart';
import 'package:magic_workout_app/core/usecases/use_case.dart';

class DeleteWorkoutUseCase extends UseCase<void, String> {
  DeleteWorkoutUseCase(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<void> call(String params) async {
    return await homeRepository.deleteWorkout(params);
  }
}
