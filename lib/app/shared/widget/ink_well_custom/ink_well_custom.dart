import 'package:flutter/material.dart';

import '../../util/colors_app.dart';
import '../../util/config_view_app.dart';

class InkWellCustom extends StatefulWidget {
  final BorderRadius borderRadius;
  final Color? colorInkWell;
  final Color colorMaterial;
  final Widget child;
  final void Function()? onTap;

  const InkWellCustom({
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.colorInkWell,
    this.colorMaterial = ColorsApp.white,
    required this.child,
    this.onTap,
    super.key,
  });

  @override
  State<InkWellCustom> createState() => _InkWellCustomState();
}

class _InkWellCustomState extends State<InkWellCustom> {
  late final Color colorInkWell;

  @override
  void initState() {
    super.initState();

    colorInkWell = widget.colorInkWell ?? ConfigViewApp.colorInkWell;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.colorMaterial,
      borderRadius: widget.borderRadius,
      child: InkWell(
        splashColor: colorInkWell,
        highlightColor: colorInkWell,
        borderRadius: widget.borderRadius,
        onTap: widget.onTap,
        child: widget.child,
      ),
    );
  }
}
