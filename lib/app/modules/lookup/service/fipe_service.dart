import 'package:dio/dio.dart';

import '../../../shared/http/http_url_util.dart';
import '../model/fipe_default_cls.dart';

class FipeService {
  final Dio dio;

  FipeService(this.dio);

  Future<List<FipeDefaultCls>> getBrands({required String vehicleType}) async {
    List<FipeDefaultCls> listBrands = [];

    var response = await dio.get<List<dynamic>>(
        HttpUrlUtil.getBrandsUrl(vehicleType: vehicleType),
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));

    if (response.data != null) {
      listBrands = (response.data as List<dynamic>)
          .map(
              (json) => FipeDefaultCls.fromMapApi(json as Map<String, dynamic>))
          .toList();
    }

    return listBrands;
  }

  Future<List<FipeDefaultCls>> getModelsVehicles({
    required String vehicleType,
    required String brandCod,
  }) async {
    List<FipeDefaultCls> listModels = [];

    var response = await dio.get<Map<String, dynamic>>(
        HttpUrlUtil.getModelsVehiclesUrl(
          vehicleType: vehicleType,
          brandCod: brandCod,
        ),
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));

    if (response.data != null && response.data!['modelos'] != null) {
      listModels = (response.data!['modelos'] as List<dynamic>)
          .map(
              (json) => FipeDefaultCls.fromMapApi(json as Map<String, dynamic>))
          .toList();
    }

    return listModels;
  }

  Future<List<FipeDefaultCls>> getYearsVehicles({
    required String vehicleType,
    required String brandCod,
    required String modelCod,
  }) async {
    List<FipeDefaultCls> listYears = [];

    var url = HttpUrlUtil.getYearsVehiclesUrl(
      vehicleType: vehicleType,
      brandCod: brandCod,
      modelCod: modelCod,
    );

    print(url);

    var response = await dio.get<List<dynamic>>(
        HttpUrlUtil.getYearsVehiclesUrl(
          vehicleType: vehicleType,
          brandCod: brandCod,
          modelCod: modelCod,
        ),
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));

    if (response.data != null) {
      listYears = (response.data as List<dynamic>)
          .map(
              (json) => FipeDefaultCls.fromMapApi(json as Map<String, dynamic>))
          .toList();
    }

    return listYears;
  }
}
