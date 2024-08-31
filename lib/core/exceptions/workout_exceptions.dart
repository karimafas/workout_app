class WorkoutRetrievalException implements Exception {
  const WorkoutRetrievalException(this.message);

  final String message;

  @override
  String toString() => 'CustomException: $message';
}
