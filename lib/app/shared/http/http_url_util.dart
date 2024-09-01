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
}
