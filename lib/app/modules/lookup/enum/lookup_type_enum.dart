enum LookupTypeEnum {
  car,
  motorcycle,
}

extension LookupTypeEnumExtension on LookupTypeEnum {
  String get value {
    switch (this) {
      case LookupTypeEnum.car:
        return 'carros';
      case LookupTypeEnum.motorcycle:
        return 'motos';
    }
  }
}
