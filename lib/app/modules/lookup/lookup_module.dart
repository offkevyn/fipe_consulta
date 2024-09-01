import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'enum/lookup_type_enum.dart';
import 'service/fipe_service.dart';
import 'state/chosen_lookup_state.dart';
import 'state/lookup_step_state.dart';
import 'view/lookup_view.dart';
import 'widget/steps/step_one/state/search_brands_state.dart';
import 'widget/steps/step_two/state/search_vehicle_state.dart';

class LookupModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(() => Dio());
    i.addSingleton(ChosenLookupState.new);
    i.addSingleton(FipeService.new);
    i.addSingleton(SearchBrandsState.new);
    i.addSingleton(SearchVehicleState.new);
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
