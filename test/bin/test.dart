import 'dart:io';

import 'package:realm_dart/realm.dart';
import 'test_model.dart';

testBool(Realm realm) {
  realm.write(() {
    /*
      @RealmModel()
class _TestModel {
  @PrimaryKey()
  late int primaryKey = 0;
  bool test1 = true;
  bool test2 = false;
}
    */
    realm.add(TestModel()); // default model
    realm.add(TestModel(primaryKey: 1));
    realm.add(TestModel(test1: false, test2: true, primaryKey: 2));
    realm.add(TestModel(test1: true, test2: false, primaryKey: 3));
  });

  final models = realm.all<TestModel>().toList();
  assert(models[0].primaryKey == 0);
  assert(models[1].primaryKey == 1);

  final m2 = models[2];
  assert(m2.primaryKey == 2);
  assert(m2.test1 == false);
  assert(m2.test2 == true);

  final m3 = models[3];
  assert(m3.primaryKey == 3);
  assert(m3.test1 == true);
  assert(m3.test2 == false);
}

cleanRealm(Realm realm) {
  realm.write(() {
    realm.deleteAll<TestModel>();
  });
}

Realm initRealm() {
  var config = Configuration([
    TestModel.schema,
  ]);
  return Realm(config);
}

void main(List<String> arguments) {
  // testModels();
  Realm realm = initRealm();
  cleanRealm(realm);
  testBool(realm);
  exit(0);
}
