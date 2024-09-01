import 'package:dio/dio.dart';

import '../../../shared/http/http_url_util.dart';
import '../model/brand.dart';

class FipeService {
  final Dio dio;

  FipeService(this.dio);

  Future<List<Brand>> getBrands({required String vehicleType}) async {
    List<Brand> listBrands = [];

    var response = await dio.get<List<dynamic>>(
        HttpUrlUtil.getBrandsUrl(vehicleType: vehicleType),
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));

    if (response.data != null) {
      listBrands = (response.data as List<dynamic>)
          .map((json) => Brand.fromMapApi(json as Map<String, dynamic>))
          .toList();
    }

    return listBrands;
  }
}
