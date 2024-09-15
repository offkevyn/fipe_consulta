import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../enum/lookup_type_enum.dart';
import '../../../../model/vehicle.dart';
import '../../../../service/fipe_service.dart';
import '../../../../state/chosen_lookup_state.dart';

class SearchVehicleState extends ChangeNotifier {
  final FipeService fipeService = Modular.get();
  final ChosenLookupState chosenLookupState = Modular.get();

  Vehicle vehicle = Vehicle.empty;

  final ValueNotifier<SearchVehicleTypeState> state = ValueNotifier(
    SearchVehicleTypeState.initial,
  );

  Future search() async {
    try {
      state.value = SearchVehicleTypeState.loading;

      vehicle = Vehicle.empty;

      await fipeService
          .getVehicle(
        vehicleType: chosenLookupState.lookupType.value,
        brandCod: chosenLookupState.chosenLookup.value.brand.cod,
        modelCod: chosenLookupState.chosenLookup.value.model.cod,
        year: chosenLookupState.chosenLookup.value.year.cod,
      )
          .then((response) {
        if (response == Vehicle.empty) {
          state.value = SearchVehicleTypeState.empty;
        } else {
          vehicle = response;
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
