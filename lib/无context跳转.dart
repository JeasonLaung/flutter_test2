import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async{
  runApp(MyApp());
}

/// 路由操作
class Router {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Future navigateBack({delta: 1, result}) async{
    
    /// 循环delta次返回
    for (var i = 0; i < delta; i++) {
      if(navigatorKey.currentState.canPop()) {
        navigatorKey.currentState.pop(result);
        // Navigator.pop(navigatorKey.currentContext, delta == i - 1 ? result : null);
      }
    }
    /// 返回一个当前页面的key
    return navigatorKey;
  }

  static Future navigateTo({@required String route}) async{
    navigatorKey.currentState.pushNamed(route);
    // print('跳转');
    // await Navigator.push(navigatorKey.currentContext, route);
    /// 返回一个当前页面的key
    return navigatorKey; 
  }

  static Future<bool> showModal({String message}) async{
/// 仿微信小程序API
    Widget dialog = CupertinoAlertDialog(
      content: Text(
        message??"我是一个仿微信小程序的苹果弹窗",
        style: TextStyle(fontSize: 20),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text("取消"),
          onPressed: () {
            // Navigator.pop(context, false);
            Router.navigateBack();
          },
        ),
        CupertinoButton(
          child: Text("确定"),
          onPressed: () {
            Router.navigateBack();
            // Navigator.pop(context, true);
          },
        ),
      ],
    );

    return await showDialog(context: navigatorKey.currentContext, builder: (_) => dialog);
  }
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
      routes: {
        '/first': (_) => HomePage(),
        '/second': (_) => SecondPage(),
        '/third': (_) => ThirdPage(),
      },
      navigatorKey: Router.navigatorKey,
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
      appBar: AppBar(title: Text('第一页'),),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('下一页'),
              onPressed: () {
                Router.navigateTo(route: '/second');
              },
            ),
            RaisedButton(
              child: Text('返回'),
              onPressed: () {
                Router.navigateBack(delta: 1);
              },
            ),
            RaisedButton(
              child: Text('展示无context dialog'),
              onPressed: () {
                // Router.showModal(message: '你好');
              },
            ),
          ]
        )
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
      appBar: AppBar(title: Text('第二页'),),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('下一页'),
              onPressed: () {
                Router.navigateTo(route: '/third');
              },
            ),
            RaisedButton(
              child: Text('返回'),
              onPressed: () {
                Router.navigateBack(delta: 2);
              },
            ),
          ]
        )
      ),
    );
  }
}

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('第三页'),),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('下一页'),
              onPressed: () {
                Router.navigateTo(route: '/first');
              },
            ),
            RaisedButton(
              child: Text('返回'),
              onPressed: () {
                Router.navigateBack(delta: 2);
              },
            ),
          ]
        )
      )
    );
  }
}