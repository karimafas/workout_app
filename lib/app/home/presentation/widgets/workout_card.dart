import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/core/assets/app_image.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/core/router/app_route.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';
import 'package:magic_workout_app/generated/locale_keys.g.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    required this.workout,
    required this.onDelete,
    super.key,
  });

  final Workout workout;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: AppFloatingButton(
            icon: Icons.delete_rounded,
            color: context.colorScheme.tertiary,
          ),
        ),
      ),
      onDismissed: (_) => onDelete(),
      child: GestureDetector(
        onTap: () => context.push(
          AppRoute.workoutDetail.path,
          extra: workout,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: context.colorScheme.primary,
          ),
          height: 90,
          width: double.infinity,
          child: Row(
            children: [
              Image.asset(
                AppImage.deadlift.path,
                height: 30,
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.name,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.surface,
                    ),
                  ),
                  const SizedBox(height: 3),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${workout.sets.length} ',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${(workout.sets.length == 1 ? LocaleKeys.home_set : LocaleKeys.home_sets).tr()} • ',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colorScheme.surface,
                          ),
                        ),
                        TextSpan(
                          text: workout.averageWeight.toStringAsFixed(1),
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: LocaleKeys.home_avg_weight.tr(),
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    LocaleKeys.workout_created_on
                        .tr(args: [workout.creationDateFormatted]),
                    style: context.textTheme.bodySmall!.copyWith(
                      color: context.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
