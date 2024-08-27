abstract class HttpUrlUtil {
  static const urlBase = 'https://parallelum.com.br/fipe/api/v1';

  static String getBrandsUrl({required String vehicleType}) {
    return '$urlBase/$vehicleType/marcas';
  }
}
