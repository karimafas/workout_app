import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_workout_app/app/features/create_workout/presentation/screens/create_workout_screen.dart';
import 'package:magic_workout_app/app/features/home/presentation/bloc/home_bloc.dart';
import 'package:magic_workout_app/app/features/home/presentation/widgets/empty_workout_list.dart';
import 'package:magic_workout_app/app/features/home/presentation/widgets/workout_card.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/core/router/app_route.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';
import 'package:magic_workout_app/core/widgets/screen_with_title.dart';
import 'package:magic_workout_app/generated/locale_keys.g.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;

    Widget body = const Center(
      child: CircularProgressIndicator(),
    );

    if (state is HomeWorkoutsRetrievalError) {
      body = Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_rounded, color: context.colorScheme.primary),
            const SizedBox(height: 15),
            Text(
              LocaleKeys.home_retrieval_error.tr(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else if (state is HomeWorkoutsRetrieved) {
      body = ScreenWithTitle(
        title: LocaleKeys.home_your_workouts.tr(),
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: state.workouts.isEmpty
                  ? [const SizedBox(height: 80), const EmptyWorkoutList()]
                  : state.workouts
                      .map(
                        (w) => Padding(
                          padding: EdgeInsets.only(
                              bottom: w == state.workouts.last ? 0 : 15),
                          child: WorkoutCard(
                            workout: w,
                            onDelete: () => context.read<HomeBloc>().add(
                                  DeleteWorkout(w.id),
                                ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          )
        ],
      );
    }

    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeWorkoutsDeletionError) {
          context.showToast(LocaleKeys.home_deletion_error.tr());
        }
      },
      child: Scaffold(
        floatingActionButton: state is! HomeWorkoutsRetrieved
            ? null
            : AppFloatingButton(
                icon: Icons.add_rounded,
                onTap: () => createWorkout(context),
              ),
        body: body,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const RetrieveWorkouts());
  }

  void createWorkout(BuildContext context) => context.push(
        AppRoute.createWorkout.path,
        extra: (
          screenType: CreateWorkoutScreenType.create,
          workoutToEdit: null,
        ),
      );
}
