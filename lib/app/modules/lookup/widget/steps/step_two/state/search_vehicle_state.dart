import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../enum/lookup_type_enum.dart';
import '../../../../model/fipe_default_cls.dart';
import '../../../../service/fipe_service.dart';
import '../../../../state/chosen_lookup_state.dart';

class SearchVehicleState extends ChangeNotifier {
  final FipeService fipeService = Modular.get();
  final ChosenLookupState chosenLookupState = Modular.get();
  final List<FipeDefaultCls> listModelsVehicles = [];

  final ValueNotifier<SearchVehicleTypeState> state = ValueNotifier(
    SearchVehicleTypeState.initial,
  );

  Future search() async {
    try {
      state.value = SearchVehicleTypeState.loading;

      await fipeService
          .getModelsVehicles(
        vehicleType: chosenLookupState.lookupType.value,
        brandCod: chosenLookupState.chosenLookup.value.brand.cod,
      )
          .then((response) {
        if (response.isEmpty) {
          state.value = SearchVehicleTypeState.empty;
        } else {
          listModelsVehicles.addAll(response);
          state.value = SearchVehicleTypeState.success;
        }
      });
    } catch (e) {
      state.value = SearchVehicleTypeState.error;
    }
  }

  Future refresh() async {
    await search();
  }
}

enum SearchVehicleTypeState {
  initial,
  loading,
  success,
  empty,
  error,
}
