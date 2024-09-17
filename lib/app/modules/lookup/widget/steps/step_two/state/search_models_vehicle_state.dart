import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../enum/lookup_type_enum.dart';
import '../../../../model/fipe_default_cls.dart';
import '../../../../service/fipe_service.dart';
import '../../../../state/chosen_lookup_state.dart';

class SearchModelsVehicleState extends ChangeNotifier {
  final FipeService fipeService = Modular.get();
  final ChosenLookupState chosenLookupState = Modular.get();
  final List<FipeDefaultCls> listModelsVehicles = [];

  final ValueNotifier<SearchModelsVehicleTypeState> state = ValueNotifier(
    SearchModelsVehicleTypeState.initial,
  );

  Future search() async {
    try {
      state.value = SearchModelsVehicleTypeState.loading;

      await fipeService
          .getModelsVehicles(
        vehicleType: chosenLookupState.lookupType.value,
        brandCod: chosenLookupState.chosenLookup.value.brand.cod,
      )
          .then((response) {
        if (response.isEmpty) {
          state.value = SearchModelsVehicleTypeState.empty;
        } else {
          listModelsVehicles.clear();
          listModelsVehicles.addAll(response);
          state.value = SearchModelsVehicleTypeState.success;
        }
      });
    } catch (e) {
      state.value = SearchModelsVehicleTypeState.error;
    }
  }

  Future refresh() async {
    listModelsVehicles.clear();
    await search();
  }
}

enum SearchModelsVehicleTypeState {
  initial,
  loading,
  success,
  empty,
  error,
}
