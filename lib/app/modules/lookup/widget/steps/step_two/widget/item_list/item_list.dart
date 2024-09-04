import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../../shared/util/colors_app.dart';
import '../../../../../../../shared/util/config_view_app.dart';
import '../../../../../../../shared/util/icon_data_app.dart';
import '../../../../../../../shared/widget/ink_well_custom/ink_well_custom.dart';

class ItemList extends StatefulWidget {
  final String title;
  final Function() onTap;
  final int? index;

  const ItemList({
    required this.title,
    required this.onTap,
    this.index,
    super.key,
  });

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late final bool _withAnimation;
  late final int? _index;
  late double _width;

  @override
  void initState() {
    super.initState();

    _withAnimation = widget.index != null;
    _index = widget.index;
    _width = 0;
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _width = ConfigViewApp.isLargeWidth(context) ? 400 : 300;
      });
    });

    int duration = _withAnimation ? 300 + (_index! * 100) : 0;

    return Align(
      alignment: Alignment.topRight,
      child: InkWellCustom(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(25),
        colorMaterial: ColorsApp.primary,
        colorInkWell: ColorsApp.primary2.withOpacity(0.3),
        child: AnimatedContainer(
          height: 60,
          width: _width,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: duration),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: PhosphorIcon(
                  IconDataApp.speedometer,
                  color: ColorsApp.secundary,
                  size: 35,
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  child: Text(
                    widget.title,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
