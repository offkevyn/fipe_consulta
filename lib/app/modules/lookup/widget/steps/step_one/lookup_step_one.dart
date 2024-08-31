import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shared/util/colors_app.dart';
import '../../../../../shared/widget/button_simple/button_simple.dart';
import '../../../../../shared/widget/ink_well_custom/ink_well_custom.dart';
import '../../../enum/lookup_type_enum.dart';
import '../../../model/brand.dart';
import '../../../state/chosen_lookup_state.dart';
import 'util/most_popular_car_brands.dart';
import 'util/show_more_dialog/show_more_dialog.dart';

class LookupStepOne extends StatefulWidget {
  const LookupStepOne({super.key});

  @override
  State<LookupStepOne> createState() => _LookupStepOneState();
}

class _LookupStepOneState extends State<LookupStepOne> {
  late ChosenLookupState _chosenLookupState;

  @override
  void initState() {
    super.initState();

    _chosenLookupState = Modular.get();
  }

  List<Widget> _itens() {
    List<Widget> itens = [];
    List<dynamic> listVehicle = [];

    if (_chosenLookupState.lookupType == LookupTypeEnum.car) {
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

  _onChosenBrand({required Brand brand}) {
    _chosenLookupState.chosenLookup.value = ChosenLookup(brand: brand);
    print('Brand: ${brand.name}');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _chosenLookupState.chosenLookup,
        builder: (context, _) {
          Brand brand = _chosenLookupState.chosenLookup.value.brand;
          if (brand.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  brand.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ColorsApp.primary2,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Escolha a marca:',
                    style: TextStyle(
                      fontSize: 24,
                      color: ColorsApp.primary,
                      fontWeight: FontWeight.w700,
                    ),
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
                      ShowMoreDialog.show(
                        context: context,
                        onChanged: (value) {
                          _onChosenBrand(brand: value);
                        },
                      );
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
        });
  }
}
