import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/app/features/home/domain/usecases/delete_workout_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  const wId = 'uuid';
  late DeleteWorkoutUseCase useCase;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    useCase = DeleteWorkoutUseCase(mockHomeRepository);
  });

  group('DeleteWorkoutUseCase', () {
    test(
      'should invoke HomeRepository when calling usecase',
      () async {
        when(() => mockHomeRepository.deleteWorkout(any()))
            .thenAnswer((_) async => {});

        await useCase(wId);

        verify(() => mockHomeRepository.deleteWorkout(wId));
        verifyNoMoreInteractions(mockHomeRepository);
      },
    );

    test(
      'should throw an exception when the repository call fails',
      () async {
        when(() => mockHomeRepository.deleteWorkout(any()))
            .thenThrow(Exception('Failed to retrieve workouts'));

        final call = useCase;

        expect(() => call(wId), throwsException);
        verify(() => mockHomeRepository.deleteWorkout(wId));
        verifyNoMoreInteractions(mockHomeRepository);
      },
    );
  });
}
