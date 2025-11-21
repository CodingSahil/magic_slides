import 'package:flutter/material.dart';

extension DoubleExtenstion on double {
  Widget get height => SizedBox(height: this);
  Widget get width => SizedBox(width: this);
}