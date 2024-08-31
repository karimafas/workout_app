import 'package:flutter/material.dart';
import 'package:magic_workout_app/app/home/presentation/widgets/workout_card.dart';
import 'package:magic_workout_app/core/constants/style_constants.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AppFloatingButton(
        icon: Icons.add_rounded,
        onTap: createWorkout,
      ),
      body: SafeArea(
        child: Padding(
          padding: commonScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Workouts',
                style: context.textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    WorkoutCard(
                      name: 'Easy Leg Push',
                      numberOfSets: 10,
                      averageWeight: 40,
                      createdAt: DateTime.now(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void createWorkout() {}
}
