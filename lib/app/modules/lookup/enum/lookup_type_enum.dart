enum LookupTypeEnum {
  car,
  motocycle,
}

extension LookupTypeEnumExtension on LookupTypeEnum {
  String get value {
    switch (this) {
      case LookupTypeEnum.car:
        return 'caros';
      case LookupTypeEnum.motocycle:
        return 'motos';
    }
  }
}
