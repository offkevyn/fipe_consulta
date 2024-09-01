import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../shared/util/colors_app.dart';
import '../../../../../shared/util/icon_data_app.dart';
import '../../../enum/lookup_type_enum.dart';
import '../../../state/chosen_lookup_state.dart';

class LookupStepTwo extends StatefulWidget {
  const LookupStepTwo({super.key});

  @override
  State<LookupStepTwo> createState() => _LookupStepTwoState();
}

class _LookupStepTwoState extends State<LookupStepTwo> {
  late ChosenLookupState _chosenLookupState;

  @override
  void initState() {
    super.initState();

    _chosenLookupState = Modular.get();
  }

  @override
  Widget build(BuildContext context) {
    String brandName = _chosenLookupState.chosenLookup.value.brand.name;
    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 10,
      ),
      children: [
        _title(brandName),
      ],
    );
  }

  Row _title(String brandName) {
    IconData icon;

    switch (_chosenLookupState.lookupType) {
      case LookupTypeEnum.car:
        icon = IconDataApp.car;
        break;
      case LookupTypeEnum.motorcycle:
        icon = IconDataApp.motorcycle;
        break;
    }

    return Row(
      children: [
        PhosphorIcon(
          icon,
          color: ColorsApp.primary,
          size: 32,
        ),
        const SizedBox(width: 8),
        Text(
          brandName,
          style: const TextStyle(
            color: ColorsApp.primary,
            fontSize: 19.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
