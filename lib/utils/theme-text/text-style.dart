import 'dart:ui';

import 'package:flutter/material.dart';

class AppTextTheme {
  static TextStyle textStyle({required Color color, double? fontSize, FontWeight? fontWeight}) {
    return TextStyle(fontFamily: 'FiraSans', color: color, fontSize: fontSize ?? 12, fontWeight: fontWeight);
  }

  static Widget text(String text, {required Color color, double? fontSize, FontWeight? fontWeight}) {
    return Text(
      text,
      style: textStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
