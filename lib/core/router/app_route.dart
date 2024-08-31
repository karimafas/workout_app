enum AppRoute {
  home('/'),
  createWorkout('/create_workout'),
  workoutDetail('/workout_detail');

  const AppRoute(this.path);
  final String path;
}
