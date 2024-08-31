import 'package:flutter/material.dart';

import '../enum/lookup_type_enum.dart';
import '../model/brand.dart';

class ChosenLookupState extends ChangeNotifier {
  late final LookupTypeEnum lookupType;

  final ValueNotifier<ChosenLookup> chosenLookup =
      ValueNotifier(ChosenLookup.empty);
}

class ChosenLookup {
  final Brand brand;

  ChosenLookup({required this.brand});

  static ChosenLookup get empty => ChosenLookup(brand: Brand.empty);
}
