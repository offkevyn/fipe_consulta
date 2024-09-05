// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class LookupStepState extends ChangeNotifier {
  final ValueNotifier<LookupStepTypeState> state = ValueNotifier(
    LookupStepTypeState.step_0_initial,
  );

  Future start() async {
    await Future.delayed(const Duration(microseconds: 0));

    state.value = LookupStepTypeState.step_1_choice_brand;
  }

  void nextStep() {
    switch (state.value) {
      case LookupStepTypeState.step_1_choice_brand:
        state.value = LookupStepTypeState.step_2_choice_model_year;
        break;
      case LookupStepTypeState.step_2_choice_model_year:
        state.value = LookupStepTypeState.step_0_initial;
        break;
      default:
        state.value = LookupStepTypeState.step_0_initial;
        break;
    }
    notifyListeners();
  }

  void previousStep() {
    switch (state.value) {
      case LookupStepTypeState.step_1_choice_brand:
        state.value = LookupStepTypeState.step_0_initial;
        break;
      case LookupStepTypeState.step_2_choice_model_year:
        state.value = LookupStepTypeState.step_1_choice_brand;
        break;
      default:
        state.value = LookupStepTypeState.step_0_initial;
        break;
    }
    notifyListeners();
  }
}

enum LookupStepTypeState {
  step_0_initial,
  step_1_choice_brand,
  step_2_choice_model_year,
}
