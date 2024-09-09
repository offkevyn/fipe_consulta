import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../../shared/util/colors_app.dart';
import '../../../../../../../shared/util/config_view_app.dart';
import '../../../../../../../shared/util/icon_data_app.dart';
import '../../../../../../../shared/widget/ink_well_custom/ink_well_custom.dart';
import 'sub_items.dart';

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
  late bool _withAnimation;
  late final int? _index;
  late double _width;

  late bool _isMonted;

  late bool _animated;
  late int _duration;

  late bool _isOpened;

  late bool _wasClicked;

  @override
  void initState() {
    super.initState();

    _withAnimation = widget.index != null;
    _index = widget.index;
    _width = 0;

    _isMonted = true;

    _animated = false;
    _duration = _withAnimation ? 300 + (_index! * 100) : 0;

    _isOpened = false;
    _wasClicked = false;
  }

  @override
  void dispose() {
    _isMonted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthDefault = ConfigViewApp.isLargeWidth(context) ? 400 : 300;

    if (_withAnimation) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (_isMonted && !_animated) {
          setState(() {
            _width = widthDefault;
          });
        }
      });

      Future.delayed(Duration(milliseconds: _duration + 1000), () {
        if (_isMonted) {
          setState(() {
            _withAnimation = false;
            _animated = true;
          });
        }
      });
    } else {
      _animated = true;
      _width = widthDefault;
    }

    return Align(
      alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _item(),
          _animated && _wasClicked
              ? SubItems(
                  isOpened: _isOpened,
                )
              : Container(),
        ],
      ),
    );
  }

  InkWellCustom _item() {
    return InkWellCustom(
      onTap: () {
        widget.onTap();

        setState(() {
          _wasClicked = true;
          _isOpened = !_isOpened;
        });
      },
      borderRadius: BorderRadius.circular(25),
      colorMaterial: ColorsApp.primary,
      colorInkWell: ColorsApp.primary2.withOpacity(0.3),
      child: AnimatedContainer(
        height: 60,
        width: _width,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: _duration),
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
                    color: ColorsApp.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
