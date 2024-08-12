import 'package:flutter/material.dart';

abstract class ConfigViewApp {
  static Color colorInkWell = Colors.blue.withOpacity(0.05);

  static double maxWidth = 500;

  static bool isLargeWidth(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return width >= maxWidth;
  }

  static double widthContent(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return isLargeWidth(context) ? maxWidth : width;
  }
}
