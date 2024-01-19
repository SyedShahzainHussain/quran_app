import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  double get screenwidth => MediaQuery.sizeOf(this).width * 1;
  double get screenheight => MediaQuery.sizeOf(this).height *1;
}
