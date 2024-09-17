abstract class HttpUrlUtil {
  static const urlBase = 'https://parallelum.com.br/fipe/api/v1';

  static String getBrandsUrl({required String vehicleType}) {
    return '$urlBase/$vehicleType/marcas';
  }

  static String getModelsVehiclesUrl({
    required String vehicleType,
    required String brandCod,
  }) {
    return '$urlBase/$vehicleType/marcas/$brandCod/modelos';
  }

  static String getYearsVehiclesUrl({
    required String vehicleType,
    required String brandCod,
    required String modelCod,
  }) {
    return '$urlBase/$vehicleType/marcas/$brandCod/modelos/$modelCod/anos';
  }

  static String getVehicleUrl({
    required String vehicleType,
    required String brandCod,
    required String modelCod,
    required String year,
  }) {
    return '$urlBase/$vehicleType/marcas/$brandCod/modelos/$modelCod/anos/$year';
  }
}
