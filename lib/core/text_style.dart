import 'package:flutter/material.dart';

/*
enum ElMessiri {
  w300(FontWeight.w300),
  w400(FontWeight.w400),
  w500(FontWeight.w500),
  w600(FontWeight.w600),
  w700(FontWeight.w700),
  ;

  final FontWeight fontWeight;
  const ElMessiri(this.fontWeight);
  TextStyle getStyle({required double fontSize, Color? color}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'ElMessiri',
      color: color,
      fontWeight: fontWeight,
    );
  }
}
*/

enum Poppins {
  w300(FontWeight.w300),
  w400(FontWeight.w400),
  w500(FontWeight.w500),
  w600(FontWeight.w600),
  w700(FontWeight.w700),
  ;

  final FontWeight fontWeight;

  const Poppins(this.fontWeight);

  TextStyle getStyle({required double fontSize, Color? color}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Poppins',
      color: color,
      fontWeight: fontWeight,
    );
  }
}
