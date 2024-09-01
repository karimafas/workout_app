import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_workout_app/app/create_workout/presentation/screens/create_workout_screen.dart';
import 'package:magic_workout_app/app/create_workout/presentation/widgets/set_card.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/core/router/app_route.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';
import 'package:magic_workout_app/core/widgets/screen_with_title.dart';
import 'package:magic_workout_app/generated/locale_keys.g.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({
    required this.workout,
    super.key,
  });

  final Workout workout;

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  late Workout displayWorkout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AppFloatingButton(
        icon: Icons.edit_rounded,
        onTap: () async {
          final result = await context.push(
            AppRoute.createWorkout.path,
            extra: (
              screenType: CreateWorkoutScreenType.edit,
              workoutToEdit: displayWorkout,
            ),
          );
          if (result is Workout) {
            setState(() => displayWorkout = result);
          }
        },
      ),
      body: ScreenWithTitle(
        showBackButton: true,
        title: displayWorkout.name,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Text(
                  LocaleKeys.workout_created_on
                        .tr(args: [displayWorkout.creationDateFormatted]),
                  style: context.textTheme.bodySmall,
                ),
                const SizedBox(height: 40),
                Text(
                  LocaleKeys.core_workout_sets.tr(),
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ...displayWorkout.sets.map(
                  (s) => Padding(
                    padding: EdgeInsets.only(
                        bottom: s == displayWorkout.sets.last ? 0 : 15),
                    child: SetCard(
                      name: s.exercise.label,
                      repetitions: s.repetitions,
                      weightInKg: s.weightInKg,
                      isDismissible: false,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    displayWorkout = widget.workout;
  }
}
