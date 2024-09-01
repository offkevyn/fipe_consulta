import 'package:flutter/material.dart';

import '../enum/lookup_type_enum.dart';
import '../model/fipe_default_cls.dart';

class ChosenLookupState extends ChangeNotifier {
  late final LookupTypeEnum lookupType;

  final ValueNotifier<ChosenLookup> chosenLookup =
      ValueNotifier(ChosenLookup.empty);
}

class ChosenLookup {
  final FipeDefaultCls brand;

  ChosenLookup({required this.brand});

  static ChosenLookup get empty => ChosenLookup(brand: FipeDefaultCls.empty);
}
