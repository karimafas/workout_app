import 'package:magic_workout_app/app/features/home/domain/repositories/home_repository.dart';
import 'package:magic_workout_app/app/features/home/domain/usecases/delete_workout_use_case.dart';
import 'package:magic_workout_app/app/features/home/domain/usecases/retrieve_workouts_use_case.dart';
import 'package:magic_workout_app/core/local_storage/local_storage_service.dart';
import 'package:magic_workout_app/core/logger/logger_service.dart';
import 'package:mocktail/mocktail.dart';

class MockRetrieveWorkoutsUseCase extends Mock
    implements RetrieveWorkoutsUseCase {}

class MockDeleteWorkoutUseCase extends Mock implements DeleteWorkoutUseCase {}

class MockHomeRepository extends Mock implements HomeRepository {}

class MockLocalStorageService extends Mock implements LocalStorageService {}

class MockLoggerService extends Mock implements LoggerService {}
