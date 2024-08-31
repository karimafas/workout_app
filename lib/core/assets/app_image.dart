enum AppImage {
  deadlift('deadlift');

  const AppImage(this.label);
  final String label;

  String get path => 'assets/images/$label.png';
}
