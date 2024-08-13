import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../util/colors_app.dart';
import '../../util/imgs_app.dart';
import '../ink_well_custom/ink_well_custom.dart';
import 'app_bar_title.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool buttonPagePop;

  const AppBarCustom({
    required this.title,
    this.buttonPagePop = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonPagePopWidget = InkWellCustom(
      colorMaterial: Colors.transparent,
      colorInkWell: ColorsApp.primary.withOpacity(0.17),
      onTap: () => Modular.to.pop(),
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: const Icon(
          Icons.arrow_back_ios,
          size: 40,
        ),
      ),
    );

    return AppBar(
      leading: buttonPagePop ? buttonPagePopWidget : null,
      iconTheme: const IconThemeData(size: 42, color: ColorsApp.primary),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: ColorsApp.primary,
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
      title: AppBarTitle(
        title: title,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
