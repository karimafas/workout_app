import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/app/home/presentation/screens/home_screen.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';

import '../../utils/widget_test_utils.dart';

void main() {
  testWidgets(
    'HomeScreen should render correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(const TestWidgetWrapper(widget: HomeScreen()));

      expect(find.text('Your Workouts'), findsOneWidget);
      expect(find.byType(AppFloatingButton), findsOneWidget);
    },
  );
}
