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
}

cleanRealm(Realm realm) {
  realm.write(() {
    realm.deleteAll();
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
  // cleanRealm(realm);
  testBool(realm);
  exit(0);
}
