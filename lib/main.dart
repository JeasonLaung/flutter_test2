
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
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
    // WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // print("--" + state.toString());
  //   switch (state) {
  //     case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
  //       print('不管切前后台都先执行');
  //       break;
  //     case AppLifecycleState.resumed:// 应用程序可见，前台
  //       print('到前台进');
  //       break;
  //     case AppLifecycleState.paused: // 应用程序不可见，后台
  //       print('到后台出');
  //       break;
  //     case AppLifecycleState.suspending: // 申请将暂时暂停
  //       print('不知道傻suspending');
  //       break;
  //   }
  // }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        child: HomePage(),
        onWillPop: () async{
          // print('用了？');
          bool temp;
          print('竟啊啊撒是的阿斯顿 奥迪啊按时撒旦撒$temp');
          /// 弹窗关闭
          temp = await showModal(context,message:'是否关闭');
          print('搞定啦啦啦啦啦啦$temp');
          return temp;

          /// 双击返回关闭
          // if(count == 0) {
          //   Timer(Duration(seconds: 2),() {
          //     setState(() {
          //       count = 0;
          //     });
          //   });
          //   setState(() {
          //     count++;
          //   });
          //   print('$count');
          //   return false;
          // } else {
          //   timer?.cancel();
          //   return true;
          // }
          
          // await showModal(context, message: '是否关闭应用');
        },
      )
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
          child: Text('弹出框'),
          onPressed: () {
            showModal(context,message: '123465798').then((val) {
              print(val);
            });
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('测试'),),
      
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