import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ESTextFontName {
  regular, light, medium, semibold, bold
}
//封装Text
class ESText extends StatelessWidget {


  ESText({
    @required this.text,
    this.maxLines,
    this.height,
    this.textAlign,
    this.fontName = ESTextFontName.regular,
    this.fontSize = 15,
    this.colorValue = 0xFF000000,
    this.overflow,
    this.textBaseline = TextBaseline.ideographic,
  });

  final String text;
  final double height;
  final ESTextFontName fontName;
  final double fontSize;
  final int colorValue;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final TextBaseline textBaseline;

  @override
  Widget build(BuildContext context) {
    var fontWeight = FontWeight.normal;

    switch (fontName) {
      case ESTextFontName.regular:
        fontWeight = FontWeight.normal;
        break;
      case ESTextFontName.light:
        fontWeight = FontWeight.w300;
        break;
      case ESTextFontName.medium:
        fontWeight = FontWeight.w500;
        break;
      case ESTextFontName.semibold:
        fontWeight = FontWeight.w600;
        break;
      case ESTextFontName.bold:
        fontWeight = FontWeight.w700;
        break;
    }
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        inherit: false,
        height: height,
        fontSize: ScreenUtil.getInstance().setSp(fontSize),
        color: Color(colorValue),
        textBaseline: textBaseline,
        fontWeight: fontWeight,
      ),
    );
  }
}