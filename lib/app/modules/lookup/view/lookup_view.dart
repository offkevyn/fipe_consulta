import 'package:fipe_consulta/app/shared/util/helper/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/util/colors_app.dart';
import '../../../shared/widget/app_bar/app_bar_custom.dart';
import '../../../shared/widget/ink_well_custom/ink_well_custom.dart';
import '../enum/lookup_type_enum.dart';
import '../states/lookup_step_state.dart';
import '../widget/steps/lookup_step_one.dart';
import '../widget/steps/lookup_step_two.dart';

class LookupView extends StatefulWidget {
  final LookupTypeEnum lookupType;

  const LookupView({
    this.lookupType = LookupTypeEnum.car,
    super.key,
  });

  @override
  State<LookupView> createState() => _LookupViewState();
}

class _LookupViewState extends State<LookupView> {
  late LookupTypeEnum _lookupType;
  late LookupStepState _lookupStepState;

  late double _heightContent;

  @override
  void initState() {
    super.initState();

    _heightContent = 200;

    _lookupStepState = Modular.get();
    _lookupStepState.start();

    _lookupType = widget.lookupType;
  }

  @override
  void dispose() {
    _lookupStepState.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: _lookupType.value.formatter(capitalize: true),
        buttonPagePop: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: const BoxDecoration(gradient: ColorsApp.backgroundGradient),
        child: ValueListenableBuilder<LookupStepTypeState>(
          valueListenable: _lookupStepState.state,
          builder: (context, state, _) {
            _lookupStepStateListener(state: state);
            return _content(state: state);
          },
        ),
      ),
    );
  }

  void _lookupStepStateListener({required LookupStepTypeState state}) {
    if (state == LookupStepTypeState.step_1_choice_brand) {
      _heightContent = 200;
    } else if (state == LookupStepTypeState.step_2_choice_model_year) {
      _heightContent = double.infinity;
    } else {
      _heightContent = 200;
    }
  }

  Align _content({required LookupStepTypeState state}) {
    return Align(
      child: Container(
        width: double.infinity,
        height: _heightContent,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: ColorsApp.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWellCustom(
          onTap: () {
            if (state != LookupStepTypeState.step_1_choice_brand) {
              _lookupStepState.state.value =
                  LookupStepTypeState.step_1_choice_brand;
            } else {
              _lookupStepState.state.value =
                  LookupStepTypeState.step_2_choice_model_year;
            }
          },
          child: Align(
            child: _stateManagement(state: state),
          ),
        ),
      ),
    );
  }

  Widget _stateManagement({required LookupStepTypeState state}) {
    switch (state) {
      case LookupStepTypeState.step_1_choice_brand:
        return const LookupStepOne();
      case LookupStepTypeState.step_2_choice_model_year:
        return const LookupStepTwo();
      default:
        return const LookupStepOne();
    }
  }
}
