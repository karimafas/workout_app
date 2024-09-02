import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:magic_workout_app/app/features/create_workout/presentation/screens/create_workout_screen.dart';
import 'package:magic_workout_app/app/features/create_workout/presentation/widgets/create_set_bottom_sheet.dart';
import 'package:magic_workout_app/app/features/home/presentation/screens/home_screen.dart';
import 'package:magic_workout_app/app/features/home/presentation/widgets/empty_workout_list.dart';
import 'package:magic_workout_app/app/features/home/presentation/widgets/workout_card.dart';
import 'package:magic_workout_app/app/features/workout_detail/presentation/screens/workout_detail_screen.dart';
import 'package:magic_workout_app/core/constants/date_format_constants.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';
import 'package:magic_workout_app/core/widgets/screen_back_button.dart';
import 'package:magic_workout_app/main.dart' as app;

import '../test/utils/widget_test_utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const workoutName = 'Workout Name';
  const editedWorkoutName = 'Edited Workout Name';

  setUpAll(() async {
    await app.main();
  });

  group('end-to-end test', () {
    testWidgets(
      'create workout flow',
      (tester) async {
        await tester.runAsync(() async {
          await pumpLocalisedApp(tester);
          await tester.pumpAndSettle();

          final fab = find.byType(AppFloatingButton);
          await tester.tap(fab);

          await tester.pumpAndSettle();

          await tester.ensureVisible(find.byType(CreateWorkoutScreen));

          final field = find.byType(TextFormField);
          await tester.enterText(field, workoutName);

          final setFab = find.byType(AppFloatingButton);
          await tester.tap(setFab);

          await tester.pumpAndSettle();

          final bottomSheet = find.byType(CreateSetBottomSheet);
          await tester.ensureVisible(bottomSheet);

          final addToWorkoutBtn = find.text('Add to Workout');
          await tester.tap(addToWorkoutBtn);

          await tester.pumpAndSettle();

          final createWorkoutBtn = find.text('Create Workout');
          await tester.tap(createWorkoutBtn);

          await tester.pumpAndSettle();

          final homeScreen = find.byType(HomeScreen);
          await tester.ensureVisible(homeScreen);

          final workoutCard = find.byType(WorkoutCard);
          await tester.ensureVisible(workoutCard);
          await tester.ensureVisible(find.text(workoutName));
          await tester.ensureVisible(
              find.text('1 set • 2.5kg avg. weight', findRichText: true));
          await tester.ensureVisible(find
              .text('Created on ${commonDateFormat.format(DateTime.now())}'));
        });
      },
    );

    testWidgets(
      'edit workout flow',
      (tester) async {
        await pumpLocalisedApp(tester);
        await tester.pumpAndSettle();

        final workoutCard = find.byType(WorkoutCard);
        await tester.tap(workoutCard);

        await tester.pumpAndSettle();

        await tester.ensureVisible(find.byType(WorkoutDetailScreen));

        final fab = find.byType(AppFloatingButton);
        await tester.tap(fab);

        await tester.pumpAndSettle();

        await tester.ensureVisible(find.byType(CreateWorkoutScreen));

        final field = find.byType(TextFormField);
        await tester.enterText(field, editedWorkoutName);

        await tester.tap(find.text('Save Workout'));

        await tester.pumpAndSettle();

        await tester.ensureVisible(find.text(editedWorkoutName));

        await tester.tap(find.byType(ScreenBackButton));
        await tester.pumpAndSettle();

        await tester.ensureVisible(find.byType(WorkoutCard));
        await tester.ensureVisible(find.text(editedWorkoutName));
      },
    );

    testWidgets(
      'delete workout flow',
      (tester) async {
        await pumpLocalisedApp(tester);
        await tester.pumpAndSettle();

        final workoutCard = find.byType(WorkoutCard);
        await tester.drag(workoutCard, const Offset(-400, 0));

        await tester.pumpAndSettle();

        expect(workoutCard, findsNothing);

        await tester.ensureVisible(find.byType(EmptyWorkoutList));
      },
    );
  });
}
