import 'package:flutter/material.dart';
import 'package:flutterapp/two_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '接口回调Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '接口回调Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({ this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textStr="开始接口回调";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(builder: (c) {
                  return TwoView(
                    onComplete: (str) {
                      //回调成功之后处理
                      textStr = str;
                      setState(() {});
                    },
                  );
                }));
              },
              child: Text(
                textStr ,//回调过来值展示
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
