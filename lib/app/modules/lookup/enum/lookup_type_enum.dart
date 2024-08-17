enum LookupTypeEnum {
  car,
  motocycle,
}

extension LookupTypeEnumExtension on LookupTypeEnum {
  String get value {
    switch (this) {
      case LookupTypeEnum.car:
        return 'carros';
      case LookupTypeEnum.motocycle:
        return 'motos';
    }
  }
}
