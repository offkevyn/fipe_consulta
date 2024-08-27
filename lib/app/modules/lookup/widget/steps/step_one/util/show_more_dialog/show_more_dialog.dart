import 'package:flutter/material.dart';

import '../../../../../../../shared/util/colors_app.dart';
import '../../../../../../../shared/widget/dropdown_search_custom/dropdown_search_custom.dart';

abstract class ShowMoreDialog {
  static Future<dynamic> show({
    required BuildContext context,
    required Function(dynamic) onChanged,
  }) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: DialogShowMoreContent(
              onChanged: onChanged,
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
    );
  }
}

class DialogShowMoreContent extends StatefulWidget {
  final Function(dynamic) onChanged;

  const DialogShowMoreContent({
    required this.onChanged,
    super.key,
  });

  @override
  State<DialogShowMoreContent> createState() => _DialogShowMoreContentState();
}

class _DialogShowMoreContentState extends State<DialogShowMoreContent> {
  late final Key _keyDropdownBrands;

  @override
  void initState() {
    super.initState();

    _keyDropdownBrands = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: ColorsApp.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Text(
        'Selecione a marca:',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorsApp.primary,
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: SizedBox(
        height: 120,
        width: 310,
        child: Center(
          child: DropdownSearchCustom<String>(
            key: _keyDropdownBrands,
            searchHintText: 'Pesquisar...',
            hintText: 'Marca:',
            items: const [
              'Audi',
              'BMW',
              'Chevrolet',
              'Citroën',
              'Fiat',
              'Ford',
              'Honda',
              'Hyundai',
              'Jeep',
              'Kia',
              'Mercedes-Benz',
              'Nissan',
              'Peugeot',
              'Renault',
              'Toyota',
              'Volkswagen',
            ],
            // initialItem: initialItem,
            onChanged: (value) {
              widget.onChanged(value);
              Navigator.pop(context);
            },
            validator: (value) {
              if (value == null) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
