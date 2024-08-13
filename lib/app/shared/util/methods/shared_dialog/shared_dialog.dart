import 'package:flutter/material.dart';

import 'dialog_module_in_construction/dialog_module_in_construction.dart';

abstract class SharedDialog {
  static Future<dynamic> simpleDialogModuleConstruction({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DialogModuleInConstruction();
      },
    );
  }

  static Future<dynamic> animationDialogModuleConstruction({
    required BuildContext context,
  }) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: const DialogModuleInConstruction(),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return  Container();
      },
    );
  }
}
