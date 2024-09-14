import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../shared/util/colors_app.dart';
import '../../../../../../../shared/widget/button_simple/button_simple.dart';
import '../../../../../../../shared/widget/progress_custom/progress_custom.dart';
import '../../../../../model/fipe_default_cls.dart';
import '../../state/search_years_vehicle_state.dart';

class SubItems extends StatefulWidget {
  final FipeDefaultCls modelVehicle;
  final bool isOpened;

  const SubItems({
    required this.modelVehicle,
    required this.isOpened,
    super.key,
  });

  @override
  State<SubItems> createState() => _SubItemsState();
}

class _SubItemsState extends State<SubItems> {
  late final SearchYearsVehicleState _searchYearsVehicleState;

  late double _height;
  late bool _isOpened;
  late bool _animated;

  @override
  void initState() {
    super.initState();

    _searchYearsVehicleState = Modular.get();

    _height = 0;
    _isOpened = widget.isOpened;
    _animated = false;
  }

  @override
  Widget build(BuildContext context) {
    print('SubItems');

    if (widget.isOpened != _isOpened) {
      _isOpened = widget.isOpened;
      _animated = false;
    }

    if (!_animated) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_isOpened) {
          _searchYearsVehicleState.search();
        }
        setState(
          () {
            if (_isOpened) {
              _height = 200;
            } else {
              _height = 0;
            }
          },
        );
        _animated = true;
      });
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 2000),
      curve: Curves.bounceOut,
      height: _height,
      color: ColorsApp.white,
      child: AnimatedBuilder(
        animation: _searchYearsVehicleState.state,
        builder: (context, _) {
          return _stateManagement(
            state: _searchYearsVehicleState.state.value,
          );
        },
      ),
    );
  }

  Widget _stateManagement({required SearchYearsVehicleTypeState state}) {
    if (_isOpened) {
      switch (state) {
        case SearchYearsVehicleTypeState.initial:
          return _loading();
        case SearchYearsVehicleTypeState.loading:
          return _loading();
        case SearchYearsVehicleTypeState.success:
          return _success();
        case SearchYearsVehicleTypeState.empty:
          return _tryAgain(erro: false);
        case SearchYearsVehicleTypeState.error:
          return _tryAgain(erro: true);
        default:
          return _tryAgain(erro: true);
      }
    } else {
      return Container(
        color: ColorsApp.red,
      );
    }
  }

  Widget _loading() {
    return const Center(
      child: ProgressCustom(
        color: ColorsApp.primary,
        size: 40,
        strokeWidth: 2.5,
      ),
    );
  }

  Widget _tryAgain({required bool erro}) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  _searchYearsVehicleState.refresh();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _success() {
    List<FipeDefaultCls> listYearsVehicles =
        _searchYearsVehicleState.listYearsVehicles;

    return ListView.builder(
      itemCount: listYearsVehicles.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(listYearsVehicles[index].name),
        );
      },
    );
  }
}
