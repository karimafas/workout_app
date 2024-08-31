import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/app/home/presentation/widgets/workout_card.dart';
import 'package:magic_workout_app/core/constants/date_format_constants.dart';

import '../../utils/widget_test_utils.dart';

const String name = 'Test Workout';
const int numberOfSets = 10;
const double averageWeight = 40;
final DateTime createdAt = DateTime.now();

void main() {
  testWidgets(
    'WorkoutCard should render correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidgetWrapper(
          widget: WorkoutCard(
            name: name,
            numberOfSets: numberOfSets,
            averageWeight: averageWeight,
            createdAt: createdAt,
            onDelete: () {},
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.text(name), findsOneWidget);
      expect(
        find.text(
            '$numberOfSets sets • ${averageWeight.toStringAsFixed(0)}kg avg. weight',
            findRichText: true),
        findsOneWidget,
      );
      expect(
        find.text('Created on ${commonDateFormat.format(createdAt)}'),
        findsOneWidget,
      );
    },
  );
}
