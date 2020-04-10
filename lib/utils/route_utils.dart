import 'package:flutter/material.dart';
import 'package:flutterapp/demo/callback/one_page.dart';
import 'package:flutterapp/demo/callback/two_page.dart';

class RouteUtlis{

  static openCallBackView({BuildContext context}){
    Navigator.of(context )
        .push(MaterialPageRoute(builder: (c) {
      return OneView();
    }));
  }

  static openTwoView({BuildContext context,void Function(String str) onComplete}){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) {
      return TwoView(
        onComplete: (str) {
          onComplete(str);
        },
      );
    }));
  }
}