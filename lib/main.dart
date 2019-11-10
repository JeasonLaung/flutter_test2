
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print("--" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        print('不管切前后台都先执行');
        break;
      case AppLifecycleState.resumed:// 应用程序可见，前台
        print('到前台进');
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        print('到后台出');
        break;
      case AppLifecycleState.suspending: // 申请将暂时暂停
        print('不知道傻suspending');
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
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
          child: Text('去下一页'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Material(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    child: Column(
                    children: <Widget>[
                      Text('是否退出？'),
                      Row(
                        children: <Widget>[
                          RaisedButton(
                            child: Text('取消'),
                            onPressed: () {

                            },
                          ),
                      // Text('是否退出？'),
                      // Text('是否退出？'),
                      // Text('是否退出？'),
                      // Text('是否退出？'),
                      // Text('是否退出？'),
                      // Text('是否退出？'),

                        ],
                      )
                    ],
                  )),
                );
              }
            );
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