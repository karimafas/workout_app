import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/app/features/home/domain/entities/workout.dart';
import 'package:magic_workout_app/app/features/home/domain/usecases/delete_workout_use_case.dart';
import 'package:magic_workout_app/app/features/home/domain/usecases/retrieve_workouts_use_case.dart';
import 'package:magic_workout_app/app/features/home/presentation/bloc/home_bloc.dart';
import 'package:magic_workout_app/core/logger/logger_service.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';
import 'package:magic_workout_app/core/usecases/use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/test_data.dart';
import '../../mocks/mocks.dart';

void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late MockRetrieveWorkoutsUseCase retrieveWorkoutsUseCase;
    late DeleteWorkoutUseCase deleteWorkoutUseCase;
    late MockLoggerService loggerService;

    setUpAll(() {
      retrieveWorkoutsUseCase = MockRetrieveWorkoutsUseCase();
      deleteWorkoutUseCase = MockDeleteWorkoutUseCase();
      loggerService = MockLoggerService();

      serviceLocator
        ..registerSingleton<RetrieveWorkoutsUseCase>(retrieveWorkoutsUseCase)
        ..registerSingleton<DeleteWorkoutUseCase>(deleteWorkoutUseCase)
        ..registerSingleton<LoggerService>(loggerService);

      registerFallbackValue(NoParams());
    });

    setUp(() {
      homeBloc = HomeBloc();
    });

    test('RetrieveWorkouts should call use case and emit HomeWorkoutsRetrieved',
        () async {
      when(() => retrieveWorkoutsUseCase.call(any()))
          .thenAnswer((_) async => [mockWorkout]);

      homeBloc.add(const RetrieveWorkouts());

      await expectLater(
          homeBloc.stream,
          emitsInOrder([
            const HomeLoading(),
            HomeWorkoutsRetrieved(workouts: [mockWorkout])
          ]));
    });

    test(
        'RetrieveWorkouts should log and emit HomeWorkoutsRetrievalError if an error occurs',
        () async {
      const errorMsg = 'Could not retrieve workouts';
      when(() => retrieveWorkoutsUseCase.call(any()))
          .thenThrow(Exception(errorMsg));

      homeBloc.add(const RetrieveWorkouts());

      await expectLater(
          homeBloc.stream,
          emitsInOrder(
              [const HomeLoading(), const HomeWorkoutsRetrievalError()]));
    });

    test('DeleteWorkout do nothing if state is not HomeWorkoutsRetrieved',
        () async {
      homeBloc = HomeBloc(homeState: const HomeInitial())
        ..add(const DeleteWorkout('1'));

      verifyNever(() => deleteWorkoutUseCase.call('1'));
    });

    test(
        'DeleteWorkout should emit HomeWorkoutsRetrieved and then call use case',
        () async {
      when(() => deleteWorkoutUseCase.call(any())).thenAnswer((_) async => {});

      homeBloc = HomeBloc(
          homeState: HomeWorkoutsRetrieved(workouts: [
        mockWorkout,
        Workout(
            id: '2',
            name: mockWorkout.name,
            createdAt: mockWorkout.createdAt,
            sets: mockWorkout.sets)
      ]))
        ..add(const DeleteWorkout('2'));

      await expectLater(
        homeBloc.stream,
        emitsInOrder(
          [
            HomeWorkoutsRetrieved(workouts: [mockWorkout]),
          ],
        ),
      );

      verify(() => deleteWorkoutUseCase.call('2')).called(1);
    });

    test(
        'DeleteWorkout should emit HomeWorkoutsRetrieved and HomeWorkoutsDeletionError if an error occurs',
        () async {
      when(() => deleteWorkoutUseCase.call(any()))
          .thenThrow(Exception('Could not delete workout'));

      homeBloc =
          HomeBloc(homeState: HomeWorkoutsRetrieved(workouts: [mockWorkout]))
            ..add(const DeleteWorkout('2'));

      await expectLater(
        homeBloc.stream,
        emitsInOrder(
          [
            HomeWorkoutsRetrieved(workouts: [mockWorkout]),
            const HomeWorkoutsDeletionError(),
          ],
        ),
      );

      verify(() => deleteWorkoutUseCase.call('2')).called(1);
    });
  });
}
