import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/app/home/data/enums/exercise.dart';
import 'package:magic_workout_app/app/home/data/models/workout_set.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/app/home/presentation/widgets/workout_card.dart';
import 'package:magic_workout_app/core/constants/date_format_constants.dart';

import '../../utils/widget_test_utils.dart';

final workout = Workout(
  id: 'test-uuid',
  name: 'Test Workout',
  createdAt: DateTime.now(),
  sets: [
    WorkoutSet(
      exercise: Exercise.barbellRow,
      weightInKg: 10,
      repetitions: 2,
    )
  ],
);

void main() {
  testWidgets(
    'WorkoutCard should render correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidgetWrapper(
          widget: WorkoutCard(
            workout: workout,
            onDelete: () {},
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.text(workout.name), findsOneWidget);
      expect(
        find.text(
            '1 sets • ${workout.averageWeight.toStringAsFixed(0)}kg avg. weight',
            findRichText: true),
        findsOneWidget,
      );
      expect(
        find.text('Created on ${commonDateFormat.format(workout.createdAt)}'),
        findsOneWidget,
      );
    },
  );
}
