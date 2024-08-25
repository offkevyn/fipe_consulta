import 'package:fipe_consulta/app/modules/lookup/widget/steps/step_one/util/most_popular_car_brands.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shared/util/colors_app.dart';
import '../../../../../shared/widget/button_simple/button_simple.dart';
import '../../../../../shared/widget/ink_well_custom/ink_well_custom.dart';
import '../../../enum/lookup_type_enum.dart';
import '../../../util/type_chosen_lookup.dart';

class LookupStepOne extends StatefulWidget {
  const LookupStepOne({super.key});

  @override
  State<LookupStepOne> createState() => _LookupStepOneState();
}

class _LookupStepOneState extends State<LookupStepOne> {
  late TypeChosenLookup _typeChosenLookup;

  @override
  void initState() {
    super.initState();

    _typeChosenLookup = Modular.get();
  }

  List<Widget> _itens() {
    List<Widget> itens = [];
    List<dynamic> listVehicle = [];

    if (_typeChosenLookup.lookupType == LookupTypeEnum.car) {
      listVehicle = MostPopularCarBrands.brands();
    }

    for (var e in listVehicle) {
      itens.add(
        ButtonSimple(
          text: e['name'],
          width: e['width'],
          onPressed: () {
            print('Clicou em ${e['name']}');
          },
        ),
      );
    }

    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Escolha a marca:',
            style: TextStyle(
                fontSize: 24,
                color: ColorsApp.primary,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 25),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: _itens(),
          ),
          const SizedBox(height: 30),
          InkWellCustom(
            borderRadius: BorderRadius.circular(50),
            colorInkWell: ColorsApp.primary.withOpacity(0.09),
            colorMaterial: Colors.black.withOpacity(0.03),
            onTap: () {
              print('Clicou em ver mais');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                'Ver mais',
                style: TextStyle(
                  fontSize: 18,
                  color: ColorsApp.primary2,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: ColorsApp.primary2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
