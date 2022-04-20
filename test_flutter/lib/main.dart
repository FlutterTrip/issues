import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'test_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late Realm _realm;
  List<TestModel> _nowRealmDatas = [];
  // final
  @override
  void initState() {
    _realm = Realm(Configuration([
      TestModel.schema,
    ]));
    getAllData();
    super.initState();
  }

  getAllData() {
    final r = _realm.all<TestModel>();
    setState(() {
      _nowRealmDatas = r.toList();
    });
  }

  cleanRealm() {
    _realm.write(() {
      _realm.deleteAll<TestModel>();
    });
    getAllData();
  }

  addDefaultModel() {
    _realm.write(() {
      _realm.add(initTestModel(getKey()));
    });
    getAllData();
  }

  addModel({int? primaryKey, required bool test1, required bool test2}) {
    _realm.write(() {
      _realm.add(
          initTestModel(primaryKey ?? getKey(), test1: test1, test2: test2));
    });
    getAllData();
  }

  TestModel initTestModel(int primaryKey, {bool? test1, bool? test2}) {
    return TestModel(
        primaryKey: primaryKey, test1: test1 ?? true, test2: test2 ?? false);
  }

  int getKey() {
    final r = _realm.query<TestModel>("TRUEPREDICATE SORT(primaryKey DESC)");
    return r.isEmpty ? 0 : r.first.primaryKey + 1;
  }

  bool isHave(int primaryKey) {
    return _realm.query<TestModel>("primaryKey == $primaryKey").isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Realm Test")),
      body: _nowRealmDatas.isEmpty
          ? const Text("NO DATA")
          : ListView(
              children: _nowRealmDatas.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                    "primaryKey: ${e.primaryKey} test1: ${e.test1} test2: ${e.test2} "),
              );
            }).toList()),
      bottomSheet: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TextButton(
                onPressed: () => cleanRealm(), child: const Text("Clean")),
            TextButton(
                onPressed: () => addDefaultModel(),
                child: const Text("AddDefaultModel")),
            TextButton(
                onPressed: () => addModel(test1: true, test2: false),
                child: const Text("true|false")),
            TextButton(
                onPressed: () => addModel(test1: false, test2: true),
                child: const Text("false|true")),
            TextButton(
                onPressed: () => addModel(test1: true, test2: true),
                child: const Text("true|true")),
            TextButton(
                onPressed: () => addModel(test1: false, test2: false),
                child: const Text("false|false")),
          ],
        ),
      ),
    );
  }
}
