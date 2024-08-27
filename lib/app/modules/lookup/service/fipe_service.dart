import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/http/http_url_util.dart';
import '../enum/lookup_type_enum.dart';
import '../model/brand.dart';
import '../util/type_chosen_lookup.dart';

class FipeService {
  final Dio dio;

  FipeService(this.dio);

  String lookupType() {
    return Modular.get<TypeChosenLookup>().lookupType.value;
  }

  Future<List<Brand>> getBrands() async {
    List<Brand> listBrands = [];

    var response = await dio.get<List<dynamic>>(
        HttpUrlUtil.getBrandsUrl(vehicleType: lookupType()),
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
