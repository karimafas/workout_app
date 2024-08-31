import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_workout_app/app/create_workout/presentation/widgets/exercise_dropdown_button.dart';
import 'package:magic_workout_app/app/create_workout/presentation/widgets/exercise_value_picker.dart';
import 'package:magic_workout_app/app/home/data/enums/exercise.dart';
import 'package:magic_workout_app/app/home/data/models/workout_set.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/core/widgets/app_button.dart';

class CreateSetBottomSheet extends StatefulWidget {
  const CreateSetBottomSheet({
    required this.onSave,
    super.key,
  });

  final Function(WorkoutSet) onSave;

  @override
  State<CreateSetBottomSheet> createState() => _CreateSetBottomSheetState();
}

class _CreateSetBottomSheetState extends State<CreateSetBottomSheet> {
  Exercise selectedExercise = Exercise.values.first;
  int repetitions = 1;
  double weightInKg = 2.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add a Set',
                  style: context.textTheme.titleLarge,
                ),
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.close_rounded,
                    color: context.colorScheme.tertiary,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            ExerciseDropdownButton(
              onChanged: (e) {
                if (e == null) {
                  return;
                }
                setState(() => selectedExercise = e);
              },
              selectedExercise: selectedExercise,
            ),
            const SizedBox(height: 30),
            ExerciseValuePicker(
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$repetitions ',
                      style: context.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'repetitions',
                      style: context.textTheme.bodyMedium!,
                    ),
                  ],
                ),
              ),
              onIncrease: () => setState(() => repetitions++),
              onDecrease: () => setState(
                () => repetitions == 0 ? null : repetitions--,
              ),
            ),
            const SizedBox(height: 20),
            ExerciseValuePicker(
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: weightInKg.toStringAsFixed(1),
                      style: context.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'kg',
                      style: context.textTheme.bodyMedium!,
                    ),
                  ],
                ),
              ),
              onIncrease: () => setState(() => weightInKg += 2.5),
              onDecrease: () => setState(
                () => weightInKg == 2.5 ? null : weightInKg -= 2.5,
              ),
            ),
            const SizedBox(height: 50),
            AppButton(
              title: 'Add to Workout',
              icon: Icons.add_circle_rounded,
              onTap: () {
                context.pop();
                widget.onSave(
                  WorkoutSet(
                    exercise: selectedExercise,
                    weightInKg: weightInKg,
                    repetitions: repetitions,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
