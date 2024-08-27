import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../shared/util/colors_app.dart';
import '../../../../../../../shared/widget/button_simple/button_simple.dart';
import '../../../../../../../shared/widget/dropdown_search_custom/dropdown_search_custom.dart';
import '../../../../../../../shared/widget/progress_custom/progress_custom.dart';
import '../../../../../model/brand.dart';
import '../../state/search_brands_state.dart';

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
  late final SearchBrandsState _searchBrandsState;

  late final Key _keyDropdownBrands;

  @override
  void initState() {
    super.initState();

    _searchBrandsState = Modular.get();

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
          child: AnimatedBuilder(
              animation: _searchBrandsState.state,
              builder: (context, _) {
                return _stateManagement(
                  state: _searchBrandsState.state.value,
                );
              }),
        ),
      ),
    );
  }

  Widget _stateManagement({required SearchBrandsTypeState state}) {
    switch (state) {
      case SearchBrandsTypeState.initial:
        _searchBrandsState.search();
        return _loading();
      case SearchBrandsTypeState.loading:
        return _loading();
      case SearchBrandsTypeState.success:
        return _success(context);
      case SearchBrandsTypeState.empty:
        return _tryAgain(erro: false);
      case SearchBrandsTypeState.error:
        return _tryAgain(erro: true);
      default:
        return _tryAgain(erro: true);
    }
  }

  Widget _loading() {
    return const ProgressCustom(
      color: ColorsApp.primary,
      size: 40,
      strokeWidth: 2.5,
    );
  }

  Widget _tryAgain({required bool erro}) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          erro ? 'Erro ao buscar marcas' : 'Nenhuma marca encontrada',
          style: TextStyle(
            color: erro ? ColorsApp.red : ColorsApp.orange,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 160,
          height: 40,
          child: ButtonSimple(
            text: 'Tentar novamente',
            colorBackground: Colors.transparent,
            onPressed: () {
              _searchBrandsState.refresh();
            },
          ),
        ),
      ],
    );
  }

  Widget _success(BuildContext context) {
    List<Brand> listBrands = _searchBrandsState.listBrands;

    return DropdownSearchCustom<Brand>(
      key: _keyDropdownBrands,
      searchHintText: 'Pesquisar...',
      hintText: 'Marca:',
      items: listBrands,
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
    );
  }
}
