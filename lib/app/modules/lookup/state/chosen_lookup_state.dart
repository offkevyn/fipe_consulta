import 'package:flutter/material.dart';

import '../enum/lookup_type_enum.dart';
import '../model/fipe_default_cls.dart';

class ChosenLookupState extends ChangeNotifier {
  late final LookupTypeEnum lookupType;

  final ValueNotifier<ChosenLookup> chosenLookup = ValueNotifier(
    ChosenLookup.empty,
  );
}

class ChosenLookup {
  FipeDefaultCls brand;
  FipeDefaultCls model;
  FipeDefaultCls year;

  ChosenLookup({
    required this.brand,
    required this.model,
    required this.year,
  });

  static ChosenLookup get empty => ChosenLookup(
        brand: FipeDefaultCls.empty,
        model: FipeDefaultCls.empty,
        year: FipeDefaultCls.empty,
      );
}
