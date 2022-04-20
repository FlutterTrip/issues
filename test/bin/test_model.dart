// ignore_for_file: unused_element

import 'package:realm_dart/realm.dart';

part 'test_model.g.dart';

@RealmModel()
class _TestModel {
  @PrimaryKey()
  late int primaryKey = 0;
  bool test1 = true;
  bool test2 = false;

  @override
  String toString() {
    return '$primaryKey, $test1, $test2';
  }
}
