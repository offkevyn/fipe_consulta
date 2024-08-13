import 'package:flutter/material.dart';

import '../../../../shared/util/colors_app.dart';
import '../../../../shared/util/methods/shared_dialog/shared_dialog.dart';
import '../../../../shared/widget/ink_well_custom/ink_well_custom.dart';

class ItemHome extends StatefulWidget {
  final String name;
  final bool adm;
  final void Function() onTap;
  final Widget icon;
  final bool inConstruction;

  const ItemHome({
    required this.name,
    required this.onTap,
    required this.icon,
    String? description,
    bool? inConstruction,
    bool? adm,
    super.key,
  })  : inConstruction = inConstruction ?? false,
        adm = adm ?? false;

  @override
  State<ItemHome> createState() => _ItemHomeState();
}

class _ItemHomeState extends State<ItemHome> {
  late BorderRadius borderRadius;
  late void Function() onTap;

  @override
  void initState() {
    super.initState();

    borderRadius = BorderRadius.circular(10.0);

    if (!widget.inConstruction) {
      onTap = widget.onTap;
    } else {
      onTap = () =>
          SharedDialog.animationDialogModuleConstruction(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(1, 1),
            blurRadius: 6.7,
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: InkWellCustom(
        colorInkWell: ColorsApp.primary.withOpacity(0.09),
        onTap: onTap,
        child: Opacity(
          opacity: widget.inConstruction ? 0.5 : 1,
          child: SizedBox(
            width: 150,
            height: 150,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();

                return true;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                        child: widget.icon,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
