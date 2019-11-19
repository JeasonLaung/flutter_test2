
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async{
  runApp(MyApp());
  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
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
      appBar: AppBar(title: Text('测试'),),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('弹出'),
              onPressed: () {
                Fluttertoast.cancel();
                Fluttertoast.showToast(
                  msg: "我我我哦我我我我我我我我我哦我我我我我我我我我哦我我我我我我我我我哦我我我我我我",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Color(0xaa111111),
                  textColor: Colors.white,
                  fontSize: 13
                );
              },
            ),
            RaisedButton(
              child: Text('取消'),
              onPressed: () {
                Fluttertoast.cancel();
              },
            ),
          ]
        )
      ),
    );
  }
}
