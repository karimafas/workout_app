import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/app/home/presentation/widgets/empty_workout_list.dart';

import '../../../utils/widget_test_utils.dart';

void main() {
  testWidgets(
    'EmptyWorkoutList should render correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestWidgetWrapper(
          widget: EmptyWorkoutList(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Icon), findsOneWidget);
      expect(
          find.text("You haven't added any workouts yet..."), findsOneWidget);
    },
  );
}
