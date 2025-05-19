import 'package:hive_flutter/hive_flutter.dart';

class AppLocalData<T> {
  late Box<T> box;

  AppLocalData({required String boxName}) {
    box = Hive.box<T>(boxName);
  }

  List<T> getAll() {
    return box.values.toList();
  }

  T? getByKey(dynamic key) {
    return box.get(key);
  }

  Future<void> insert(dynamic key, T entity) async {
    await box.put(key, entity);
  }

  Future<void> update(dynamic key, T entity) async {
    await box.put(key, entity);
  }

  Future<void> delete(dynamic key) async {
    await box.delete(key);
  }
}
