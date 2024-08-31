enum AppRoute {
  home('/'),
  createWorkout('/create_workout');

  const AppRoute(this.path);
  final String path;
}
