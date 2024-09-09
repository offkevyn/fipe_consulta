import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../enum/lookup_type_enum.dart';
import '../../../../model/fipe_default_cls.dart';
import '../../../../service/fipe_service.dart';
import '../../../../state/chosen_lookup_state.dart';

class SearchYearsVehicleState extends ChangeNotifier {
  final FipeService fipeService = Modular.get();
  final ChosenLookupState chosenLookupState = Modular.get();
  final List<FipeDefaultCls> listYearsVehicles = [];

  final ValueNotifier<SearchYearsVehicleTypeState> state = ValueNotifier(
    SearchYearsVehicleTypeState.initial,
  );

  Future search() async {
    try {
      state.value = SearchYearsVehicleTypeState.loading;

      await Future.delayed(const Duration(seconds: 1));

      await fipeService
          .getYearsVehicles(
        vehicleType: chosenLookupState.lookupType.value,
        brandCod: chosenLookupState.chosenLookup.value.brand.cod,
        modelCod: chosenLookupState.chosenLookup.value.model.cod,
      )
          .then((response) {
        if (response.isEmpty) {
          state.value = SearchYearsVehicleTypeState.empty;
        } else {
          listYearsVehicles.clear();
          listYearsVehicles.addAll(response);
          state.value = SearchYearsVehicleTypeState.success;
        }
      });
    } catch (e) {
      state.value = SearchYearsVehicleTypeState.error;
    }
  }

  Future refresh() async {
    listYearsVehicles.clear();
    await search();
  }
}

enum SearchYearsVehicleTypeState {
  initial,
  loading,
  success,
  empty,
  error,
}
