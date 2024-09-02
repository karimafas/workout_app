import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/app/features/home/data/enums/exercise.dart';
import 'package:magic_workout_app/app/features/home/data/repositories/home_repository_impl.dart';
import 'package:magic_workout_app/app/features/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/local_storage/local_storage_service.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late HomeRepositoryImpl homeRepository;
  late MockLocalStorageService mockLocalStorageService;

  final createdAt = DateTime.now().toIso8601String();
  final mockWorkoutsData = [
    {
      'id': '1',
      'name': 'Workout 1',
      'createdAt': createdAt,
      'sets': [
        {'repetitions': 10, 'weightInKg': 50.0, 'exercise': 'squat'}
      ]
    },
    {
      'id': '2',
      'name': 'Workout 2',
      'createdAt': createdAt,
      'sets': [
        {'repetitions': 12, 'weightInKg': 40.0, 'exercise': 'benchPress'}
      ]
    }
  ];

  setUp(() {
    mockLocalStorageService = MockLocalStorageService();
    serviceLocator
        .registerSingleton<LocalStorageService>(mockLocalStorageService);
    homeRepository = HomeRepositoryImpl();
  });

  setUpAll(() {
    registerFallbackValue(StorageKey.workouts);
  });

  tearDown(() {
    serviceLocator.unregister<LocalStorageService>();
  });

  group('HomeRepositoryImpl', () {
    test('retrieveWorkouts returns list of Workout entities', () async {
      when(() => mockLocalStorageService.retrieveData(StorageKey.workouts, []))
          .thenReturn(mockWorkoutsData);

      final result = await homeRepository.retrieveWorkouts();

      expect(result, isA<List<Workout>>());
      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[0].name, 'Workout 1');
      expect(result[0].sets.length, 1);
      expect(result[0].sets[0].repetitions, 10);
      expect(result[0].sets[0].weightInKg, 50.0);
      expect(result[0].sets[0].exercise, Exercise.squat);
    });

    test('retrieveWorkouts throws exception when null is returned', () async {
      when(() => mockLocalStorageService.retrieveData(StorageKey.workouts, []))
          .thenReturn(null);

      expect(
        () => homeRepository.retrieveWorkouts(),
        throwsA(isA<Exception>()),
      );
    });

    test('deleteWorkout removes workout from storage', () async {
      when(() => mockLocalStorageService.retrieveData(StorageKey.workouts, []))
          .thenReturn(mockWorkoutsData);
      when(() => mockLocalStorageService.saveData(any(), any()))
          .thenReturn(null);

      await homeRepository.deleteWorkout('1');

      verify(() => mockLocalStorageService.saveData(StorageKey.workouts,
          mockWorkoutsData.where((w) => w['id'] != '1').toList())).called(1);
    });

    test('deleteWorkout does nothing when workouts list is empty', () async {
      when(() => mockLocalStorageService.retrieveData(StorageKey.workouts, []))
          .thenReturn([]);

      await homeRepository.deleteWorkout('1');

      verifyNever(() => mockLocalStorageService.saveData(any(), any()));
    });
  });
}
