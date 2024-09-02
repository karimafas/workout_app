import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/app/features/home/domain/entities/workout.dart';
import 'package:magic_workout_app/app/features/home/domain/usecases/retrieve_workouts_use_case.dart';
import 'package:magic_workout_app/core/usecases/use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late RetrieveWorkoutsUseCase useCase;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    useCase = RetrieveWorkoutsUseCase(mockHomeRepository);
  });

  group('RetrieveWorkoutsUseCase', () {
    final workouts = [
      Workout(id: '0', name: 'Workout 1', createdAt: DateTime.now(), sets: []),
      Workout(id: '1', name: 'Workout 2', createdAt: DateTime.now(), sets: []),
    ];

    test(
      'should return list of Workouts when calling usecase',
      () async {
        when(() => mockHomeRepository.retrieveWorkouts())
            .thenAnswer((_) async => workouts);

        final result = await useCase(NoParams());

        expect(result, equals(workouts));
        verify(() => mockHomeRepository.retrieveWorkouts());
        verifyNoMoreInteractions(mockHomeRepository);
      },
    );

    test(
      'should throw an exception when the repository call fails',
      () async {
        when(() => mockHomeRepository.retrieveWorkouts())
            .thenThrow(Exception('Failed to retrieve workouts'));

        final call = useCase;

        expect(() => call(NoParams()), throwsException);
        verify(() => mockHomeRepository.retrieveWorkouts());
        verifyNoMoreInteractions(mockHomeRepository);
      },
    );
  });
}
