import 'package:flutter/material.dart';

extension IntegerExtenstion on int {
  Widget get height => SizedBox(height: toDouble());
  Widget get width => SizedBox(width: toDouble());
}