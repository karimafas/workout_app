import 'package:get_it/get_it.dart';
import 'package:magic_workout_app/app/create_workout/data/repositories/create_workout_repository_impl.dart';
import 'package:magic_workout_app/app/create_workout/domain/usecases/create_workout_use_case.dart';
import 'package:magic_workout_app/app/home/data/repositories/home_repository_impl.dart';
import 'package:magic_workout_app/app/home/domain/repositories/home_repository.dart';
import 'package:magic_workout_app/app/home/domain/usecases/delete_workout_use_case.dart';
import 'package:magic_workout_app/app/home/domain/usecases/retrieve_workouts_use_case.dart';
import 'package:magic_workout_app/core/local_storage/local_storage_service.dart';
import 'package:magic_workout_app/core/logger/logger_service.dart';
import 'package:uuid/uuid.dart';

final serviceLocator = GetIt.instance;
final logger = serviceLocator.get<LoggerService>();

class ServiceLocator {
  static Future<void> registerSingletons() async {
    final localStorage = LocalStorageService();
    await localStorage.init();

    final homeRepository = HomeRepositoryImpl();
    final createWorkoutRepository = CreateWorkoutRepositoryImpl();

    serviceLocator
      ..registerSingleton<LocalStorageService>(localStorage)
      ..registerSingleton<Uuid>(const Uuid())
      ..registerSingleton<LoggerService>(LoggerService())
      ..registerSingleton<HomeRepository>(homeRepository)
      ..registerSingleton<RetrieveWorkoutsUseCase>(
          RetrieveWorkoutsUseCase(homeRepository))
      ..registerSingleton<DeleteWorkoutUseCase>(
          DeleteWorkoutUseCase(homeRepository))
      ..registerSingleton<CreateWorkoutUseCase>(
          CreateWorkoutUseCase(createWorkoutRepository));
  }
}
