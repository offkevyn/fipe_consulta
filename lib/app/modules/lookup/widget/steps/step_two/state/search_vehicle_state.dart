import 'package:flutter/material.dart';

class SearchVehicleState extends ChangeNotifier {
  final ValueNotifier<SearchVehicleTypeState> state = ValueNotifier(
    SearchVehicleTypeState.initial,
  );

  Future search() async {
    try {
      state.value = SearchVehicleTypeState.loading;
      Future.delayed(const Duration(milliseconds: 500), () {
        state.value = SearchVehicleTypeState.success;
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
