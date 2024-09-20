// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../Controller/app_initialization_controller.dart';

class AppInitializationState extends ChangeNotifier {
  final AppInitializationController _appInitializationController =
      AppInitializationController();

  final ValueNotifier<AppInitializationTypeState> state = ValueNotifier(
    AppInitializationTypeState.initial,
  );

  final ValueNotifier<AppInitializationStep> currentStep = ValueNotifier(
    AppInitializationStep.initial,
  );

  Future initialize() async {
    try {
      state.value = AppInitializationTypeState.loading;

      currentStep.value = AppInitializationStep.check_app_update;
      await _appInitializationController.checkAppUpdate();

      currentStep.value = AppInitializationStep.finalizing;
      await Future.delayed(const Duration(milliseconds: 850));

      state.value = AppInitializationTypeState.finished;
    } catch (e) {
      state.value = AppInitializationTypeState.error;
    }
  }
}

enum AppInitializationTypeState {
  initial,
  loading,
  finished,
  error,
}

enum AppInitializationStep {
  initial,
  check_app_update,
  finalizing,
}

extension AppInitializationStepExtension on AppInitializationStep {
  String get name {
    switch (this) {
      case AppInitializationStep.initial:
        return 'Inicializando';
      case AppInitializationStep.check_app_update:
        return 'Verificando atualizações';
      case AppInitializationStep.finalizing:
        return 'Finalizando';
    }
  }
}
