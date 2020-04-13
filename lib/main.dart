import 'package:flutter/material.dart';
import 'package:flutterapp/utils/route_utils.dart';
import 'package:flutterapp/view/es_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'MyFlutterDemo'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<_MyDemoWidgetModelType> _list = _MyDemoWidgetModelType.initData();

  @override
  Widget build(BuildContext context) {
    bool _isBuilded = false;

    if(_isBuilded == false) {
      ScreenUtil.instance = ScreenUtil(width: 360, height: 640)..init(context);
    }
    _isBuilded = true;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: CustomScrollView(shrinkWrap: true, slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate(
                  _listWidget(),
                ),
              ),
            )
          ]),
        ));
  }

  List<Widget> _listWidget() {
    List<Widget> result = [];
    for (var item in _list) {
      result.add(_itemWidget(
          content: item.content,
          onTap: () {
            _itemWidgetClick(item.type);
          }));
    }
    return result;
  }

  Widget _itemWidget({String content,void Function() onTap}) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(150),
      height: ScreenUtil.getInstance().setHeight(47),
      margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
      child: FlatButton(
        textColor: Color(0xff2172f6),
        child: ESText(
          text: content??"",
          fontSize: 15,
          colorValue: 0xff2172f6,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xff2172f6),
            width: 1,
          ),
          borderRadius:
          BorderRadius.circular(ScreenUtil.getInstance().setHeight(4)),
        ),
        onPressed: ()  {
          onTap();
        },
      ),
    );
  }


  _itemWidgetClick(_MyDemoWidgetType type) {
    switch (type) {
      case _MyDemoWidgetType.callbackDemo:
        RouteUtils.openCallBackView(context: context);
        break;
      case _MyDemoWidgetType.providerDemo:
        RouteUtils.openCallBackView(context: context);
        break;
      default:
        break;
    }
  }


}
enum _MyDemoWidgetType {
  callbackDemo,
  providerDemo,
}
class _MyDemoWidgetModelType {
  _MyDemoWidgetType type = _MyDemoWidgetType.callbackDemo;
  String content = "";

  static List<_MyDemoWidgetModelType> initData() {
    List<_MyDemoWidgetType> types = [
      _MyDemoWidgetType.callbackDemo,
      _MyDemoWidgetType.providerDemo,
    ];
    return types.map((type) {
      var model = _MyDemoWidgetModelType();
      model.type = type;
      switch (type) {
        case _MyDemoWidgetType.callbackDemo:
          model.content = "接口回调Demo";
          break;
        case _MyDemoWidgetType.providerDemo:
          model.content = "prividerDemo";
          break;
      }
      return model;
    }).toList();
  }
}


