import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/utils/toast_utils.dart';

import 'es_text_widget.dart';

class ESWidgetFactory {

  /* 获取通用脚手架 */
  static Widget scaffold({
    @required BuildContext context,
    @required Widget body,
    Key scaffoldKey,
    Widget appBar,
    String title,
    bool resizeToAvoidBottomInset = true,
    bool automaticallyImplyLeading = true,
    bottomNavigationBar,
  }) {

    Widget leading;
    if (ModalRoute.of(context)?.canPop ?? false) {
      leading = new IconButton(
        icon: Image.asset("images/default/call_back.png"),
        onPressed: () {
          Navigator.maybePop(context);
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      key: scaffoldKey,
      appBar: appBar ?? (title != null ? AppBar(
          automaticallyImplyLeading: automaticallyImplyLeading,
          elevation: 0.0,
          centerTitle: true,
          title: ESText(
            text: title,
            fontSize: 18,
            colorValue: 0xFFFFFFFF,
          ),
          leading: leading,
      ) : null),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  static Widget addWillPopScope({@required Widget child, @required BuildContext context}) {
    return WillPopScope(
      onWillPop: () {
        return _doubleClickBack(context);
      },
      child: child,
    );
  }

  static int _last = 0;
  static Future<bool> _doubleClickBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      return Future.value(true);
    }

    int now = DateTime.now().millisecondsSinceEpoch;

    if (now - _last > 1000) {
      _last = DateTime.now().millisecondsSinceEpoch;

      ToastUtils.showText(context: context, msg: "再按一次退出程序");

      return Future.value(false);
    } else {
      ToastUtils.dismiss();
      return Future.value(true);
    }
  }

  static Widget emptyView({Size size, String image, String text, double offset}) {
    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(180),
            height: ScreenUtil.getInstance().setWidth(168),
            child: Image.asset(image, fit: BoxFit.fill,),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(16),
                  color: Color(0xff666666)
              ),
            ),
          ),
          Container(
            width: 5,
            height: offset,
          )
        ],
      ),
    );
  }
}