import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../shared/util/colors_app.dart';
import '../../../../../shared/widget/button_simple/button_simple.dart';
import '../../../../../shared/widget/ink_well_custom/ink_well_custom.dart';
import '../../../enum/lookup_type_enum.dart';
import '../../../model/fipe_default_cls.dart';
import '../../../state/chosen_lookup_state.dart';
import 'util/most_popular_car_brands.dart';
import 'util/show_more_dialog/show_more_dialog.dart';

class LookupStepOne extends StatefulWidget {
  final Function onFinished;
  const LookupStepOne({
    required this.onFinished,
    super.key,
  });

  @override
  State<LookupStepOne> createState() => _LookupStepOneState();
}

class _LookupStepOneState extends State<LookupStepOne>
    with SingleTickerProviderStateMixin {
  late ChosenLookupState _chosenLookupState;

  late double _animationContainer;
  late int _durationAnimationContainer;
  late double _animationText;
  late int _durationAnimationText;

  late bool _chosenBrand;

  @override
  void initState() {
    super.initState();

    _chosenLookupState = Modular.get();

    _animationContainer = 1.0;
    _animationText = 0.0;
    _durationAnimationContainer = _durationAnimationText = 700;

    _chosenBrand = false;
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
            _onChosenBrand(
              brand: FipeDefaultCls(
                name: e['name'],
                cod: e['cod'],
              ),
            );
          },
        ),
      );
    }

    return itens;
  }

  Future _onChosenBrand({required FipeDefaultCls brand}) async {
    if (!_chosenBrand) {
      _chosenBrand = true;
      _chosenLookupState.chosenLookup.value = ChosenLookup.empty..brand = brand;

      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _animationContainer = 0.0;
        });
      });

      Future.delayed(Duration(milliseconds: _durationAnimationContainer - 250),
          () {
        setState(() {
          _animationText = 1.0;
        });
      });

      Future.delayed(Duration(milliseconds: _durationAnimationContainer + 600),
          () {
        setState(() {
          _animationText = 0.0;
        });

        widget.onFinished();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _chosenLookupState.chosenLookup,
      builder: (context, _) {
        FipeDefaultCls brand = _chosenLookupState.chosenLookup.value.brand;
        return SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: _animationContainer,
                duration: Duration(
                  milliseconds: _durationAnimationContainer,
                ),
                child: AnimatedScale(
                  scale: _animationContainer,
                  duration: Duration(
                    milliseconds: _durationAnimationContainer,
                  ),
                  curve: Curves.easeInOutCirc,
                  // curve: Curves.easeInOutBack,
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
                          // _onChosenBrand(brand: FipeDefaultCls(name: 'Toyotaoff', cod: '123'));
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
                ),
              ),
              AnimatedOpacity(
                opacity: _animationText,
                duration: Duration(
                  milliseconds: _durationAnimationText,
                ),
                child: AnimatedScale(
                  scale: _animationText,
                  duration: Duration(
                    milliseconds: _durationAnimationText,
                  ),
                  curve: Curves.bounceOut,
                  child: Text(
                    brand.name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorsApp.primary,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
