import 'package:flutter/material.dart';

abstract class ColorsApp {
  static const primary = Color(0xFF26143E);
  static const primary2 = Color(0xFF6E588A);
  static const secundary = Color(0xFFFFD700);
  static const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.black, Color(0xFF483A5B)],
  );

  static const white = Color(0xFFFAFAFA);
  static const gray = Color(0xFF494A4F);
  static const black = Color(0xFF272727);
  static const red = Color(0xFFFF0042);
  static const orange = Color(0xFFFF7800);
  static const green = Color(0xFF439881);
}
