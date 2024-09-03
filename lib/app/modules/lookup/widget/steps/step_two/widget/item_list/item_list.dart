import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../../shared/util/colors_app.dart';
import '../../../../../../../shared/util/config_view_app.dart';
import '../../../../../../../shared/util/icon_data_app.dart';
import '../../../../../../../shared/widget/ink_well_custom/ink_well_custom.dart';

class ItemList extends StatelessWidget {
  final String title;
  final Function() onTap;

  const ItemList({
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: InkWellCustom(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        colorMaterial: ColorsApp.primary,
        colorInkWell: ColorsApp.primary2.withOpacity(0.3),
        child: Container(
          height: 60,
          width: ConfigViewApp.isLargeWidth(context) ? 400 : 300,
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
                    title,
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
