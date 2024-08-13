import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../shared/util/colors_app.dart';
import '../../../../shared/util/imgs_app.dart';
import '../../../../shared/widget/app_bar/app_bar_title.dart';
import '../../../../shared/widget/ink_well_custom/ink_well_custom.dart';

class AppBarHomeCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHomeCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWellCustom(
        colorMaterial: Colors.transparent,
        colorInkWell: ColorsApp.primary.withOpacity(0.17),
        onTap: () => Scaffold.of(context).openDrawer(),
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(color: Colors.transparent),
          child: const PhosphorIcon(
            PhosphorIconsRegular.list,
            color: ColorsApp.secundary,
            size: 45,
          ),
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Image(
            image: AssetImage(ImgsApp.logo),
            width: 45,
          ),
        )
      ],
      backgroundColor: ColorsApp.primary,
      title: const AppBarTitle(
        title: 'Home',
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
