import 'package:flutter/material.dart';

void main() async{
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: MaterialApp(
        home: HomePage()
      )
    );
  }
}

///
/// 应用代码
/// 
/// 
/// 
/// 
/// 


class HomePage extends StatefulWidget {
  final int index;
  HomePage({this.index = 1});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('第${widget.index}页'),),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('下一页'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => HomePage(index: widget.index+1,)
                ));
              },
            ),
            RaisedButton(
              child: Text('展示无context toast'),
              onPressed: () {
                showToast('123465');
              },
            ),
            RaisedButton(
              child: Text('展示无context modal'),
              onPressed: () {
                showModal('是否确定',onConfirm: () {
                  showToast('点击了确定');
                },onCancel: () {
                  showToast('点击了取消');

                });
              },
            ),
          ]
        )
      ),
    );
  }
}


/// ----------------------
/// 
/// 核心代码
/// 
/// ----------------------


/// 全局key
final GlobalKey<_AppContainerFinderState> _keyFinder = GlobalKey(debugLabel: 'overlay_support');
OverlayState get _overlayState{
  final context = _keyFinder.currentContext;
  if (context == null) return null;
  NavigatorState navigator;
  void visitor(Element element) {
    if (navigator != null) return;
    /// 如果是一个页面路由
    if (element.widget is Navigator) {
      /// navigator返回他的state
      navigator = (element as StatefulElement).state;
    } else {
      /// 否则递归
      element.visitChildElements(visitor);
    }
  }
  /// 就是总能找到最后一页的overlay
  context.visitChildElements(visitor);
  return navigator.overlay;
}

/// 静态app容器
class AppContainer extends StatelessWidget {
  final Widget child;
  AppContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return AppContainerFinder(child: child, key: _keyFinder);
  }
}
/// 动态app容器内容
class AppContainerFinder extends StatefulWidget {
  final Widget child;
  AppContainerFinder({Key key,this.child}) : super(key: key);
  @override
  _AppContainerFinderState createState() => _AppContainerFinderState();
}

class _AppContainerFinderState extends State<AppContainerFinder> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}














//// ------------------------
///   弹窗函数
///
///
///
///




/// 显示toast
showToast(msg) {
  OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
    //外层使用Positioned进行定位，控制在Overlay中的位置
      return Positioned(
          top: MediaQuery.of(context).size.height * 0.7,
          child: Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(msg),
                  ),
                  color: Colors.grey,
                ),
              ),
            ),
          ));
    });
    //往Overlay中插入插入OverlayEntry
    _overlayState.insert(overlayEntry);
    //两秒后，移除Toast
    Future.delayed(Duration(seconds: 2)).then((value) {
      overlayEntry.remove();
    });
}


showModal(String msg, {onConfirm, onCancel}) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
    //外层使用Positioned进行定位，控制在Overlay中的位置
      return Container(
        color: Color(0x66333333),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.white,
                height: 100,
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.center,
                child: Text('$msg', style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0
                ),),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Material(
                child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(20),
                        child: Text('取消'),
                      ),
                      onTap: () {
                        overlayEntry.remove();
                        return onCancel != null ? onCancel() : false;
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(20),
                        child: Text('确定'),
                      ),
                      onTap: () {
                        overlayEntry.remove();
                        return onConfirm != null ? onConfirm() : false;
                      },
                    ),
                  ),
                  
                ],
              ))
              )
            ],
          ),
        ),
      );
    });
    //往Overlay中插入插入OverlayEntry
    _overlayState.insert(overlayEntry);
    //两秒后，移除Toast
    // Future.delayed(Duration(seconds: 2)).then((value) {
    //   overlayEntry.remove();
    // });
}