import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ToastUtilsPosition {
  top, center, bottom
}

enum ToastUtilsType {
  text, image, textImg
}

class ToastUtils {

  static ToastView preToast;

  static showText({
    @required BuildContext context,
    @required String msg,
    ToastUtilsPosition position = ToastUtilsPosition.bottom,
  }) {
    if (context == null || msg == null) {
      return;
    }
    _show(
        context: context,
        msg: msg,
        position: position,
        type: ToastUtilsType.text);
  }

  static showImage({
    @required BuildContext context,
    @required String image,
    Size backSize,
    Size imgSize,
    ToastUtilsPosition position = ToastUtilsPosition.center,
  }) {
    if (context == null || image == null) {
      return;
    }
    _show(
        context: context,
        image: image,
        backSize: backSize,
        imgSize: imgSize,
        position: position,
        type: ToastUtilsType.image);
  }

  static showTextImg({
    @required BuildContext context,
    @required String msg,
    @required String image,
    Size backSize,
    Size imgSize,
    ToastUtilsPosition position = ToastUtilsPosition.center,
  }) {
    if (context == null || msg == null || image == null) {
      return;
    }
    _show(
        context: context,
        msg: msg,
        image: image,
        backSize: backSize,
        imgSize: imgSize,
        position: position,
        type: ToastUtilsType.textImg);
  }

  static dismiss() {
    preToast?.dismiss();
    preToast = null;
  }

  static _show({
    @required BuildContext context,
    String msg,
    String image,
    Size backSize,
    Size imgSize,
    ToastUtilsPosition position,
    ToastUtilsType type
  }) {
    assert(position != null);
    assert(type != null);

    dismiss();
    var overlayState = Overlay.of(context);
    var controllerShowAnim = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );
    var controllerShowOffset = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 350),
    );
    var controllerHide = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );
    var opacityAnim1 =
    new Tween(begin: 0.0, end: 1.0).animate(controllerShowAnim);
    var controllerCurvedShowOffset = new CurvedAnimation(
        parent: controllerShowOffset, curve: _BounceOutCurve._());
    var offsetAnim =
    new Tween(begin: 30.0, end: 0.0).animate(controllerCurvedShowOffset);
    var opacityAnim2 = new Tween(begin: 1.0, end: 0.0).animate(controllerHide);

    OverlayEntry overlayEntry;
    overlayEntry = new OverlayEntry(builder: (context) {
      return ToastWidget(
        opacityAnim1: opacityAnim1,
        opacityAnim2: opacityAnim2,
        offsetAnim: offsetAnim,
        child: _buildToastLayout(msg, image, type, position, backSize, imgSize),
      );
    });
    var toastView = ToastView();
    toastView.overlayEntry = overlayEntry;
    toastView.controllerShowAnim = controllerShowAnim;
    toastView.controllerShowOffset = controllerShowOffset;
    toastView.controllerHide = controllerHide;
    toastView.overlayState = overlayState;
    preToast = toastView;
    toastView._show();
  }

  static LayoutBuilder _buildToastLayout(
      String msg,
      String image,
      ToastUtilsType type,
      ToastUtilsPosition position,
      Size backSize,
      Size imgSize
      ) {

    var bottom = 0.0;
    switch (position) {
      case ToastUtilsPosition.top:
        bottom = 0.8;
        break;
      case ToastUtilsPosition.center:
        bottom = 0.5;
        break;
      case ToastUtilsPosition.bottom:
        bottom = 0.1;
        break;
    }

    var height = 0.0;
    var bSize = backSize;
    if (type == ToastUtilsType.image || type == ToastUtilsType.textImg) {
      if (bSize == null) {
        var w = ScreenUtil.getInstance().setWidth(120);
        bSize = Size(w, w);
      }
      height = bSize.height;
    }

    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              child: _buildChild(type, msg, image, bSize, imgSize),
              margin: EdgeInsets.only(
                bottom: constraints.biggest.height * bottom - height + 44,
                left: constraints.biggest.width * 0.2,
                right: constraints.biggest.width * 0.2,
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    });
  }

  static Widget _buildChild(
      ToastUtilsType type,
      String msg,
      String image,
      Size backSize,
      Size imgSize,
      ) {

    switch (type) {
      case ToastUtilsType.text:
        return Container(
          child: Text(
            "${msg}",
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil.getInstance().setSp(13),
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0xFF111111).withOpacity(0.7),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        );
      case ToastUtilsType.image:
        var imgWidget = Image.asset(image);
        if (imgSize != null) {
          imgWidget = Image.asset(
              image,
              fit: BoxFit.fill,
              width: imgSize.width,
              height: imgSize.height);
        }
        return Container(
          width: backSize.width,
          height: backSize.height,
          child: Center(
            child: imgWidget,
          ),
          decoration: BoxDecoration(
            color: Color(0xFF111111).withOpacity(0.7),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        );
      case ToastUtilsType.textImg:

        var imgWidget = Image.asset(image);
        if (imgSize != null) {
          imgWidget = Image.asset(
              image,
              fit: BoxFit.fill,
              width: imgSize.width,
              height: imgSize.height);
        }
        return Container(
          width: backSize.width,
          height: backSize.height,
          decoration: BoxDecoration(
            color: Color(0xFF111111).withOpacity(0.7),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 1,
                height: ScreenUtil.getInstance().setWidth(30),
              ),
              imgWidget,
              SizedBox(
                width: 1,
                height: ScreenUtil.getInstance().setWidth(16),
              ),
              Text(
                "${msg}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil.getInstance().setSp(13),
                ),
              )
            ],
          ),
        );
        break;
    }
  }
}

class ToastView {
  OverlayEntry overlayEntry;
  AnimationController controllerShowAnim;
  AnimationController controllerShowOffset;
  AnimationController controllerHide;
  OverlayState overlayState;
  bool dismissed = false;

  _show() async {
    overlayState.insert(overlayEntry);
    controllerShowAnim.forward();
    controllerShowOffset.forward();
    await Future.delayed(Duration(milliseconds: 2000));
    this.dismiss();
  }

  dismiss() async {
    if (dismissed) {
      return;
    }
    this.dismissed = true;
    controllerHide.forward();
    await Future.delayed(Duration(milliseconds: 250));
    overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  final Widget child;
  final Animation<double> opacityAnim1;
  final Animation<double> opacityAnim2;
  final Animation<double> offsetAnim;

  ToastWidget(
      {this.child, this.offsetAnim, this.opacityAnim1, this.opacityAnim2});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacityAnim1,
      child: child,
      builder: (context, child_to_build) {
        return Opacity(
          opacity: opacityAnim1.value,
          child: AnimatedBuilder(
            animation: offsetAnim,
            builder: (context, _) {
              return Transform.translate(
                offset: Offset(0, offsetAnim.value),
                child: AnimatedBuilder(
                  animation: opacityAnim2,
                  builder: (context, _) {
                    return Opacity(
                      opacity: opacityAnim2.value,
                      child: child_to_build,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _BounceOutCurve extends Curve {
  const _BounceOutCurve._();

  @override
  double transform(double t) {
    t -= 1.0;
    return t * t * ((2 + 1) * t + 2) + 1.0;
  }
}