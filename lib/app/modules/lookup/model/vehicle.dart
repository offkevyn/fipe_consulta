class Vehicle {
  final int vehicleType;
  final String value;
  final String brand;
  final String model;
  final int yearOfManufacture;
  final String fuel;
  final String fipeCode;
  final String referenceMonth;
  final String fuelAbbreviation;

  Vehicle({
    required this.vehicleType,
    required this.value,
    required this.brand,
    required this.model,
    required this.yearOfManufacture,
    required this.fuel,
    required this.fipeCode,
    required this.referenceMonth,
    required this.fuelAbbreviation,
  });

  static Vehicle get empty => Vehicle(
        vehicleType: 0,
        value: '',
        brand: '',
        model: '',
        yearOfManufacture: 0,
        fuel: '',
        fipeCode: '',
        referenceMonth: '',
        fuelAbbreviation: '',
      );

  factory Vehicle.fromMapApi(Map<String, dynamic> map) {
    return Vehicle(
      vehicleType: map['TipoVeiculo'] != null ? map['TipoVeiculo'] as int : 0,
      value: map['Valor'] ?? '',
      brand: map['Marca'] ?? '',
      model: map['Modelo'] ?? '',
      yearOfManufacture: map['AnoModelo'] != null ? map['AnoModelo'] as int : 0,
      fuel: map['Combustivel'] ?? '',
      fipeCode: map['CodigoFipe'] ?? '',
      referenceMonth: map['MesReferencia'] ?? '',
      fuelAbbreviation: map['SiglaCombustivel'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Vehicle(vehicleType: $vehicleType, value: $value, brand: $brand, model: $model, yearOfManufacture: $yearOfManufacture, fuel: $fuel, fipeCode: $fipeCode, referenceMonth: $referenceMonth, fuelAbbreviation: $fuelAbbreviation)';
  }
}
