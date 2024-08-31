import 'package:hive_flutter/hive_flutter.dart';

enum HiveBox {
  workouts;
}

enum StorageKey {
  workouts;
}

class LocalStorageService {
  late Box<List<dynamic>> workoutsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    workoutsBox = await Hive.openBox(HiveBox.workouts.name);
  }

  void saveData(StorageKey key, List<dynamic> data) =>
      workoutsBox.put(key.name, data);

  List<dynamic>? retrieveData(
    StorageKey key,
    List<dynamic> defaultValue,
  ) =>
      workoutsBox.get(key.name, defaultValue: defaultValue);
}
