import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../shared/util/colors_app.dart';
import '../../../../../shared/util/icon_data_app.dart';
import '../../../../../shared/widget/lottie_custom/lottie_custom.dart';
import '../../../enum/lookup_type_enum.dart';
import '../../../model/fipe_default_cls.dart';
import '../../../state/chosen_lookup_state.dart';
import '../../../state/lookup_step_state.dart';
import 'state/search_models_vehicle_state.dart';
import 'widget/item_list/item_list.dart';

class LookupStepTwo extends StatefulWidget {
  const LookupStepTwo({super.key});

  @override
  State<LookupStepTwo> createState() => _LookupStepTwoState();
}

class _LookupStepTwoState extends State<LookupStepTwo> {
  late LookupStepState _lookupStepState;
  late ChosenLookupState _chosenLookupState;
  late SearchModelsVehicleState _searchVehicleState;

  late bool _startAnimation;

  late FipeDefaultCls _modelVehicleSelected;

  @override
  void initState() {
    super.initState();

    _lookupStepState = Modular.get();
    _chosenLookupState = Modular.get();
    _searchVehicleState = Modular.get();
    _searchVehicleState.search();

    _startAnimation = true;

    _modelVehicleSelected = FipeDefaultCls.empty;
  }

  void _onChosenModelVehicle({required FipeDefaultCls modelVehicle}) {
    _chosenLookupState.chosenLookup.value.model = modelVehicle;

    setState(() {
      _modelVehicleSelected = _chosenLookupState.chosenLookup.value.model;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        _lookupStepState.previousStep();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 10,
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _searchVehicleState.state,
            builder: (context, _) {
              return _stateManagement(
                state: _searchVehicleState.state.value,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _stateManagement({required SearchModelsVehicleTypeState state}) {
    switch (state) {
      case SearchModelsVehicleTypeState.loading:
        return const LottieCustom(
          lottieType: LottieType.loading,
        );
      case SearchModelsVehicleTypeState.error:
        return LottieCustom(
          lottieType: LottieType.failed,
          onPressed: _refresh,
        );
      case SearchModelsVehicleTypeState.empty:
        return LottieCustom(
          lottieType: LottieType.empty,
          onPressed: _refresh,
        );
      case SearchModelsVehicleTypeState.success:
        return _success();
      default:
        return const LottieCustom(
          lottieType: LottieType.loading,
        );
    }
  }

  Widget _success() {
    String brandName = _chosenLookupState.chosenLookup.value.brand.name;
    List<FipeDefaultCls> listModelsVehicles =
        _searchVehicleState.listModelsVehicles;

    int numAnimation = MediaQuery.of(context).size.height ~/ 75;

    return ListView.separated(
      itemCount: listModelsVehicles.length + 1,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
      itemBuilder: (context, index) {
        if (index >= numAnimation + 1) {
          _startAnimation = false;
        }
        if (index == 0) {
          return _title(brandName);
        } else {
          FipeDefaultCls modelVehicle = listModelsVehicles[index - 1];

          return ItemList(
            title: modelVehicle.name,
            isFocused: _modelVehicleSelected == modelVehicle,
            index:
                index - 1 < numAnimation && _startAnimation ? index - 1 : null,
            onTap: () {
              _onChosenModelVehicle(
                modelVehicle: modelVehicle,
              );
            },
          );
        }
      },
    );
  }

  Row _title(String brandName) {
    IconData icon;

    switch (_chosenLookupState.lookupType) {
      case LookupTypeEnum.car:
        icon = IconDataApp.car;
        break;
      case LookupTypeEnum.motorcycle:
        icon = IconDataApp.motorcycle;
        break;
    }

    return Row(
      children: [
        PhosphorIcon(
          icon,
          color: ColorsApp.primary,
          size: 32,
        ),
        const SizedBox(width: 8),
        Text(
          brandName,
          style: const TextStyle(
            color: ColorsApp.primary,
            fontSize: 19.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _refresh() {
    _searchVehicleState.refresh();
  }
}
