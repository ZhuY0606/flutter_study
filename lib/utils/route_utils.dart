import 'package:flutter/material.dart';
import 'package:flutterapp/demo/callback/one_page.dart';
import 'package:flutterapp/demo/callback/two_page.dart';
import 'package:flutterapp/demo/provider/model/provider_model.dart';
import 'package:flutterapp/demo/provider/provider_two_view.dart';
import 'package:provider/provider.dart';
class RouteUtils{

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

  static openProviderTwoView({BuildContext context,ProviderModel model}){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) {
      return ChangeNotifierProvider.value(
        value: model,
        child: ProviderTwoView(),
      );
    }));
  }
}