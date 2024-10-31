import 'package:hive_flutter/hive_flutter.dart';
import 'package:interview/features/models/todo_model.dart';

class LocalStorageUtils {
  static final LocalStorageUtils instance = LocalStorageUtils._internal();

  factory LocalStorageUtils() {
    return instance;
  }
  LocalStorageUtils._internal();

  Box? _box;

  // Initialize Hive and open a box
  Future<void> initHive() async {
    Hive.initFlutter('todo_app'); // Specify directory for Hive storage
    Hive.registerAdapter(TodoModelAdapter());
  }

  Future<void> saveData<T>(int key, T value) async {
    var box = await Hive.openBox<T>("$T-BOX");
    await box.put(key, value);
  }

  Future<void> saveAllData<T>(Map<dynamic, T> values) async {
    var box = await Hive.openBox<T>("$T-BOX");
    await box.putAll(values);
  }

  Future<T?> getData<T>(int key) async {
    var box = await Hive.openBox<T>("$T-BOX");
    return box.get(key);
  }

  Future<List<T>> getAllData<T>() async {
    var box = await Hive.openBox<T>("$T-BOX");
    return box.values.toList();
  }

  Future<void> deleteData<T>(int key) async {
    var box = await Hive.openBox<T>("$T-BOX");
    await box.delete(key);
  }

  // Close Hive box
  Future<void> closeHive() async {
    await _box?.close();
  }
}
