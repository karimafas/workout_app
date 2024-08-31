import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_workout_app/app/home/presentation/bloc/home_bloc.dart';
import 'package:magic_workout_app/app/home/presentation/widgets/empty_workout_list.dart';
import 'package:magic_workout_app/app/home/presentation/widgets/workout_card.dart';
import 'package:magic_workout_app/core/constants/style_constants.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;

    Widget body = const Center(
      child: CircularProgressIndicator(),
    );

    if (state is HomeWorkoutsRetrievalError) {
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_rounded, color: context.colorScheme.primary),
            const SizedBox(height: 15),
            const Text(
              'There was an error retrieving workouts.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else if (state is HomeWorkoutsRetrieved) {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Workouts',
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: state.workouts.isEmpty
                  ? [const SizedBox(height: 80), const EmptyWorkoutList()]
                  : state.workouts
                      .map(
                        (w) => WorkoutCard(
                          name: w.name,
                          numberOfSets: w.sets.length,
                          averageWeight: w.averageWeight,
                          createdAt: w.createdAt,
                          onDelete: () {},
                        ),
                      )
                      .toList(),
            ),
          )
        ],
      );
    }

    return Scaffold(
      floatingActionButton: state is! HomeWorkoutsRetrieved
          ? null
          : AppFloatingButton(
              icon: Icons.add_rounded,
              onTap: createWorkout,
            ),
      body: SafeArea(
        child: Padding(
          padding: commonScreenPadding,
          child: body,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const RetrieveWorkouts());
  }

  void createWorkout() {}
}
