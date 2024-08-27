import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'enum/lookup_type_enum.dart';
import 'service/fipe_service.dart';
import 'states/lookup_step_state.dart';
import 'util/type_chosen_lookup.dart';
import 'view/lookup_view.dart';
import 'widget/steps/step_one/state/search_brands_state.dart';

class LookupModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(() => Dio());
    i.addSingleton(TypeChosenLookup.new);
    i.addSingleton(FipeService.new);
    i.addSingleton(SearchBrandsState.new);
    i.add(LookupStepState.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => LookupView(
        lookupType: r.args.data['lookupType'] as LookupTypeEnum,
      ),
    );
    r.wildcard(child: (_) => const LookupView());
  }
}
