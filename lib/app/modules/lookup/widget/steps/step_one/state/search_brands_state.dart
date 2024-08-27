import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../model/brand.dart';
import '../../../../service/fipe_service.dart';

class SearchBrandsState extends ChangeNotifier {
  final FipeService fipeService = Modular.get();
  final List<Brand> listBrands = [];

  final ValueNotifier<SearchBrandsTypeState> state = ValueNotifier(
    SearchBrandsTypeState.initial,
  );

  Future search() async {
    try {
      state.value = SearchBrandsTypeState.loading;

      if (listBrands.isEmpty) {
        await fipeService.getBrands().then((response) {
          if (response.isEmpty) {
            state.value = SearchBrandsTypeState.empty;
          } else {
            listBrands.addAll(response);
            state.value = SearchBrandsTypeState.success;
          }
        });
      } else {
        state.value = SearchBrandsTypeState.success;
      }
    } catch (e) {
      state.value = SearchBrandsTypeState.error;
    }
  }

  Future refresh() async {
    listBrands.clear();
    await search();
  }
}

enum SearchBrandsTypeState {
  initial,
  loading,
  success,
  empty,
  error,
}
