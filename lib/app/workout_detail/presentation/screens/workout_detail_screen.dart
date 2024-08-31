import 'package:flutter/material.dart';
import 'package:magic_workout_app/app/create_workout/presentation/widgets/set_card.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';
import 'package:magic_workout_app/core/widgets/screen_with_title.dart';

class WorkoutDetailScreen extends StatelessWidget {
  const WorkoutDetailScreen({
    required this.workout,
    super.key,
  });

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const AppFloatingButton(
        icon: Icons.edit_rounded,
      ),
      body: ScreenWithTitle(
        showBackButton: true,
        title: workout.name,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Text(
                  workout.formattedCreationDate,
                  style: context.textTheme.bodySmall,
                ),
                const SizedBox(height: 40),
                Text(
                  'Workout Sets',
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ...workout.sets.map(
                  (s) => Padding(
                    padding: EdgeInsets.only(
                        bottom: s == workout.sets.last ? 0 : 15),
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
}
