import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../shared/util/colors_app.dart';
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
      content: const SizedBox(
        height: 120,
        width: 310,
        child: Center(
          child: Text('Vehicle Details Dialog'),
        ),
      ),
    );
  }
}
