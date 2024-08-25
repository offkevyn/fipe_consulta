import 'package:flutter/material.dart';

import '../../util/colors_app.dart';
import '../ink_well_custom/ink_well_custom.dart';

class ButtonSimple extends StatelessWidget {
  final String text;
  final double width;
  final double sizeFont;
  final void Function()? onPressed;

  const ButtonSimple({
    required this.text,
    double? width,
    this.sizeFont = 16,
    this.onPressed,
    super.key,
  }) : width = width ?? 110;

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      borderRadius: BorderRadius.circular(5),
      colorInkWell: ColorsApp.primary.withOpacity(0.09),
      colorMaterial: ColorsApp.secundary,
      onTap: onPressed,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
          border: Border.all(
            color: ColorsApp.primary,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorsApp.primary,
              fontSize: sizeFont,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
