import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/app/features/home/presentation/widgets/workout_card.dart';
import 'package:magic_workout_app/core/constants/date_format_constants.dart';

import '../../../data/test_data.dart';
import '../../../utils/widget_test_utils.dart';

void main() {
  testWidgets(
    'WorkoutCard should render correctly',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        final widget = await buildLocalisedWidget(
            child: TestWidgetWrapper(
          widget: WorkoutCard(
            workout: mockWorkout,
            onDelete: () {},
          ),
        ));
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.byType(Image), findsOneWidget);
        expect(find.text(mockWorkout.name), findsOneWidget);
        expect(
          find.text(
              '1 set • ${mockWorkout.averageWeight.toStringAsFixed(1)}kg avg. weight',
              findRichText: true),
          findsOneWidget,
        );
        expect(
          find.text(
              'Created on ${commonDateFormat.format(mockWorkout.createdAt)}'),
          findsOneWidget,
        );
      });
    },
  );
}
