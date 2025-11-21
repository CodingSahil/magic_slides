import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void debugLog(String message) {
  if(kDebugMode) {
    log(message);
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key, this.size = 15, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(color: color ?? Theme.of(context).colorScheme.onSurface,strokeWidth: 2,),
    );
  }
}
