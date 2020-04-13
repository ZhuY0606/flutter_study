import 'package:flutter/cupertino.dart';
import 'package:flutterapp/utils/route_utils.dart';
import 'package:flutterapp/view/es_text_widget.dart';
import 'package:flutterapp/view/views_factory.dart';

class OneView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OneViewViewState();
  }
}

class _OneViewViewState extends State<OneView> {
  String callBackStr = "接口回调";

  @override
  Widget build(BuildContext context) {
    return ESWidgetFactory.scaffold(
        context: context, title: "接口回调Demo", body: _bodyWidget());
  }

  Widget _bodyWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {
          RouteUtils.openTwoView(
              context: context,
              onComplete: (str) {
                callBackStr = str;
                setState(() {});
              });
        },
        child: ESText(text: callBackStr ?? ""),
      ),
      alignment: Alignment.center,
    );
  }
}
