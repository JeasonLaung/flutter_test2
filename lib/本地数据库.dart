
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
Database database;
void main() async{
  var databasesPath = await getDatabasesPath();
  String path = '${databasesPath}demo.db';
  database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
  });
  // Insert some records in a transaction
  await database.transaction((txn) async {
    int id1 = await txn.rawInsert(
        'INSERT INTO Test(name, value, num) VALUES("${DateTime.now()}", 1234, 456.789)');
    print('inserted1: $id1');
    int id2 = await txn.rawInsert(
        'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
        ['${DateTime.now()}', 12345678, 3.1416]);
    print('inserted2: $id2');
  });


  runApp(MyApp());
  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  Timer timer;
  int count = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('测试生命周期'),),
      body: Center(
        child: RaisedButton(
          child: Text('第二页'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SecondPage();
            }));
            // showModal(context,message: '123465798').then((val) {
            //   print(val);
            // });
          },
        ),
      ),
    );
  }
}


class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  List l;
  @override
  void initState() { 
    super.initState();
    getData();
  }
  getData() async{
    List<Map> list = await database.rawQuery('SELECT * FROM Test');
    setState(() {
      l = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(l == null) {
      return Scaffold(appBar:AppBar(title: Text('第二页'),));
    }
    return Scaffold(
      appBar: AppBar(title: Text('第二页'),),
      body: ListView(
        children: List.generate(l.length, (index) {
          return ListTile(title: Text('${l[index]['name']}'));
        }),
      ),
    );
  }
}

/// 仿微信小程序API
Future<bool> showModal(context,{String message}) async{
  Widget dialog = CupertinoAlertDialog(
    content: Text(
      message??"我是一个仿微信小程序的苹果弹窗",
      style: TextStyle(fontSize: 20),
    ),
    actions: <Widget>[
      CupertinoButton(
        child: Text("取消"),
        onPressed: () {
          Navigator.pop(context, false);
        },
      ),
      CupertinoButton(
        child: Text("确定"),
        onPressed: () {
          Navigator.pop(context, true);
        },
      ),
    ],
  );

  return await showDialog(context: context, builder: (_) => dialog);
}