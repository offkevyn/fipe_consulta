import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../../shared/util/colors_app.dart';
import '../../../../../../../shared/util/icon_data_app.dart';
import '../../../../../../../shared/widget/lottie_custom/lottie_custom.dart';
import '../../../../../model/vehicle.dart';
import '../../state/search_vehicle_state.dart';

abstract class VehicleDetailsDialog {
  static Future<dynamic> show({
    required BuildContext context,
  }) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: const _VehicleDetailsDialogContent(),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
    );
  }
}

class _VehicleDetailsDialogContent extends StatefulWidget {
  const _VehicleDetailsDialogContent();

  @override
  State<_VehicleDetailsDialogContent> createState() =>
      _VehicleDetailsDialogContentState();
}

class _VehicleDetailsDialogContentState
    extends State<_VehicleDetailsDialogContent> {
  late SearchVehicleState _searchVehicleState;

  @override
  void initState() {
    super.initState();

    _searchVehicleState = Modular.get();
    _searchVehicleState.search();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: ColorsApp.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: SizedBox(
        height: 300,
        width: 350,
        child: Center(
          child: AnimatedBuilder(
            animation: _searchVehicleState.state,
            builder: (context, _) {
              return _stateManagement(
                state: _searchVehicleState.state.value,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _stateManagement({required SearchVehicleTypeState state}) {
    double? widthLottie = 250;

    switch (state) {
      case SearchVehicleTypeState.loading:
        return LottieCustom(
          width: widthLottie,
          lottieType: LottieType.loading,
        );
      case SearchVehicleTypeState.error:
        return LottieCustom(
          width: widthLottie,
          lottieType: LottieType.failed,
          onPressed: _refresh,
        );
      case SearchVehicleTypeState.empty:
        return LottieCustom(
          width: widthLottie,
          lottieType: LottieType.empty,
          onPressed: _refresh,
        );
      case SearchVehicleTypeState.success:
        return _success();
      default:
        return LottieCustom(
          width: widthLottie,
          lottieType: LottieType.loading,
        );
    }
  }

  Widget _success() {
    Vehicle vehicle = _searchVehicleState.vehicle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: PhosphorIcon(
            IconDataApp.speedometer,
            color: ColorsApp.secundary,
            size: 135,
          ),
        ),
        Container(
          height: 1.2,
          decoration: BoxDecoration(
            color: ColorsApp.primary,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fieldInDetails(
                  title: 'Marca: ',
                  value: vehicle.brand,
                ),
                _fieldInDetails(
                  title: 'Modelo: ',
                  value: vehicle.model,
                ),
                _fieldInDetails(
                  title: 'Ano do modelo: ',
                  value: vehicle.yearOfManufacture.toString(),
                ),
                _fieldInDetails(
                  title: 'Combustível: ',
                  value: vehicle.fuel,
                ),
                _fieldInDetails(
                  title: 'Valor: ',
                  value: vehicle.value,
                ),
                _fieldInDetails(
                  title: 'Mês referência: ',
                  value: vehicle.referenceMonth,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _fieldInDetails({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
        left: 10,
        right: 10,
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(
            fontSize: 16.8,
            height: 1.08,
          ),
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                color: ColorsApp.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                color: ColorsApp.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _refresh() {
    _searchVehicleState.refresh();
  }
}
