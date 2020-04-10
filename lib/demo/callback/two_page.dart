import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/es_text_widget.dart';
import 'package:flutterapp/view/views_factory.dart';

class TwoView extends StatefulWidget {
  final void Function(String str) onComplete;

  TwoView({this.onComplete});

  @override
  State<StatefulWidget> createState() {
    return _TwoViewState();
  }
}

class _TwoViewState extends State<TwoView> {
  @override
  Widget build(BuildContext context) {
    return ESWidgetFactory.scaffold(
        context: context,
        title: "接口回调Demo",
        body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: GestureDetector(
            child: ESText(text: "开始接口回调"),
            onTap: () {
              widget.onComplete("接口回调完成");
              Navigator.pop(context);
            },
          ),
        ));
  }
}
