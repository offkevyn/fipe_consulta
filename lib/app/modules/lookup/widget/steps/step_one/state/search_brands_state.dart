import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../enum/lookup_type_enum.dart';
import '../../../../model/fipe_default_cls.dart';
import '../../../../service/fipe_service.dart';
import '../../../../state/chosen_lookup_state.dart';

class SearchBrandsState extends ChangeNotifier {
  final FipeService fipeService = Modular.get();
  final List<FipeDefaultCls> listBrands = [];

  final ValueNotifier<SearchBrandsTypeState> state = ValueNotifier(
    SearchBrandsTypeState.initial,
  );

  String _lookupType() {
    return Modular.get<ChosenLookupState>().lookupType.value;
  }

  Future search() async {
    try {
      state.value = SearchBrandsTypeState.loading;

      if (listBrands.isEmpty) {
        await fipeService
            .getBrands(
          vehicleType: _lookupType(),
        )
            .then((response) {
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
