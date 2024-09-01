import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/app/home/domain/usecases/retrieve_workouts_use_case.dart';
import 'package:magic_workout_app/app/home/presentation/bloc/home_bloc.dart';
import 'package:magic_workout_app/app/home/presentation/screens/home_screen.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';
import 'package:magic_workout_app/core/usecases/use_case.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';
import 'package:mocktail/mocktail.dart';

import '../../../data/test_data.dart';
import '../../../mocks/mocks.dart';
import '../../../utils/widget_test_utils.dart';

void main() {
  late RetrieveWorkoutsUseCase retrieveWorkoutsUseCase;

  setUpAll(() {
    retrieveWorkoutsUseCase = MockRetrieveWorkoutsUseCase();

    serviceLocator
        .registerSingleton<RetrieveWorkoutsUseCase>(retrieveWorkoutsUseCase);

    registerFallbackValue(NoParams());
  });

  testWidgets(
    'HomeScreen should render correctly',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        when(() => retrieveWorkoutsUseCase.call(any()))
            .thenAnswer((_) async => [mockWorkout]);

        final widget = await buildLocalisedWidget(
          child: BlocProvider(
            create: (_) => HomeBloc(),
            child: const HomeScreen(),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.text('Your Workouts'), findsOneWidget);
        expect(find.byType(AppFloatingButton), findsOneWidget);
      });
    },
  );
}
