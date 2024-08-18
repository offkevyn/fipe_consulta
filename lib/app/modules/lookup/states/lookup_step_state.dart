// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class LookupStepState extends ChangeNotifier {
  late final ValueNotifier<LookupStepTypeState> state;

  void start() {
    state = ValueNotifier(LookupStepTypeState.step_0_initial);
  }
}

enum LookupStepTypeState {
  step_0_initial,
  step_1_choice_brand,
  step_2_choice_model_year,
}
