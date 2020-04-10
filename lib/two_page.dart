import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      alignment: Alignment.center,
      color: Colors.white,
      child: GestureDetector(
        child: Text("接口回调"),
        onTap: () {
          widget.onComplete("这是回调过来的值");
          Navigator.pop(context);
        },
      ),
    );
  }
}
