// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class TestModel extends _TestModel with RealmEntity, RealmObject {
  static var _defaultsSet = false;

  TestModel({
    int primaryKey = 0,
    bool test1 = true,
    bool test2 = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObject.setDefaults<TestModel>({
        'primaryKey': 0,
        'test1': true,
        'test2': false,
      });
    }
    RealmObject.set(this, 'primaryKey', primaryKey);
    RealmObject.set(this, 'test1', test1);
    RealmObject.set(this, 'test2', test2);
  }

  TestModel._();

  @override
  int get primaryKey => RealmObject.get<int>(this, 'primaryKey') as int;
  @override
  set primaryKey(int value) => throw RealmUnsupportedSetError();

  @override
  bool get test1 => RealmObject.get<bool>(this, 'test1') as bool;
  @override
  set test1(bool value) => RealmObject.set(this, 'test1', value);

  @override
  bool get test2 => RealmObject.get<bool>(this, 'test2') as bool;
  @override
  set test2(bool value) => RealmObject.set(this, 'test2', value);

  @override
  Stream<RealmObjectChanges<TestModel>> get changes =>
      RealmObject.getChanges<TestModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(TestModel._);
    return const SchemaObject(TestModel, [
      SchemaProperty('primaryKey', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('test1', RealmPropertyType.bool),
      SchemaProperty('test2', RealmPropertyType.bool),
    ]);
  }
}
