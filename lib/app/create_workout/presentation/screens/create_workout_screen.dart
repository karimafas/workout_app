import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_workout_app/app/create_workout/presentation/bloc/create_workout_bloc.dart';
import 'package:magic_workout_app/app/create_workout/presentation/widgets/create_set_bottom_sheet.dart';
import 'package:magic_workout_app/app/create_workout/presentation/widgets/set_card.dart';
import 'package:magic_workout_app/app/home/data/models/workout_model.dart';
import 'package:magic_workout_app/app/home/data/models/workout_set.dart';
import 'package:magic_workout_app/app/home/domain/entities/workout.dart';
import 'package:magic_workout_app/app/home/presentation/bloc/home_bloc.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';
import 'package:magic_workout_app/core/widgets/app_button.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';
import 'package:magic_workout_app/core/widgets/screen_with_title.dart';
import 'package:uuid/uuid.dart';

enum CreateWorkoutScreenType {
  create,
  edit;

  bool get isEditing => this == CreateWorkoutScreenType.edit;
}

class CreateWorkoutScreen extends StatelessWidget {
  const CreateWorkoutScreen({
    required this.screenType,
    this.workoutToEdit,
    super.key,
  });

  final CreateWorkoutScreenType screenType;
  final Workout? workoutToEdit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateWorkoutBloc>(
      create: (_) => CreateWorkoutBloc(),
      child: CreateWorkoutView(
        screenType: screenType,
        workoutToEdit: workoutToEdit,
      ),
    );
  }
}

class CreateWorkoutView extends StatefulWidget {
  const CreateWorkoutView({
    required this.screenType,
    required this.workoutToEdit,
    super.key,
  });

  final CreateWorkoutScreenType screenType;
  final Workout? workoutToEdit;

  @override
  State<CreateWorkoutView> createState() => _CreateWorkoutViewState();
}

class _CreateWorkoutViewState extends State<CreateWorkoutView> {
  List<WorkoutSet> sets = [];
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateWorkoutBloc, CreateWorkoutState>(
      listener: (context, state) {
        if (state is CreateWorkoutSuccess) {
          context.read<HomeBloc>().add(const RetrieveWorkouts());
          context.pop();
        } else if (state is UpdateWorkoutSuccess) {
          context.read<HomeBloc>().add(const RetrieveWorkouts());
          context.pop(state.updatedWorkout);
        } else if (state is CreateWorkoutFailure) {
          context.showToast('There was an issue creating your workout.');
        } else if (state is UpdateWorkoutFailure) {
          context.showToast('There was an issue updating your workout.');
        }
      },
      child: Scaffold(
        floatingActionButton: AppButton(
          title:
              '${widget.screenType == CreateWorkoutScreenType.create ? 'Create' : 'Save'} Workout',
          icon: Icons.sports_martial_arts_rounded,
          onTap: () {
            if (widget.screenType.isEditing) {
              updateWorkout(context);
            } else {
              createWorkout(context);
            }
          },
          disabled: nameController.text.trim().isEmpty || sets.isEmpty,
          isLoading:
              context.watch<CreateWorkoutBloc>().state is CreateWorkoutLoading,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ScreenWithTitle(
            key: ValueKey(widget.screenType),
            title:
                '${widget.screenType == CreateWorkoutScreenType.create ? 'Create a' : 'Edit'} Workout',
            showBackButton: true,
            children: [
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.only(bottom: 80, left: 20, right: 20),
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        label: const Text('Workout name'),
                        labelStyle: context.textTheme.bodySmall,
                      ),
                      style: context.textTheme.bodyMedium,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 80),
                    Text(
                      'Workout Sets',
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Add one or more sets to compose your workout.',
                      style: context.textTheme.bodySmall,
                    ),
                    if (sets.isNotEmpty) const SizedBox(height: 20),
                    ...sets.map(
                      (s) => Padding(
                        padding:
                            EdgeInsets.only(bottom: s == sets.last ? 0 : 15),
                        child: SetCard(
                          name: s.exercise.label,
                          repetitions: s.repetitions,
                          weightInKg: s.weightInKg,
                          onDelete: () => setState(() => sets.remove(s)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      child: AppFloatingButton(
                        icon: Icons.add_rounded,
                        size: 45,
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => CreateSetBottomSheet(
                            onSave: (s) => setState(() => sets.add(s)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.screenType.isEditing) {
      nameController.text = widget.workoutToEdit?.name ?? '';
      sets = widget.workoutToEdit?.sets ?? [];
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void createWorkout(BuildContext context) {
    final workout = WorkoutModel(
      id: serviceLocator.get<Uuid>().v4(),
      name: nameController.text,
      createdAt: DateTime.now(),
      sets: sets,
    );
    context.read<CreateWorkoutBloc>().add(CreateWorkout(workout: workout));
  }

  void updateWorkout(BuildContext context) {
    if (widget.workoutToEdit == null) {
      return;
    }

    final workout = WorkoutModel(
      id: widget.workoutToEdit!.id,
      name: nameController.text,
      createdAt: DateTime.now(),
      sets: sets,
    );
    context.read<CreateWorkoutBloc>().add(UpdateWorkout(workout: workout));
  }
}
