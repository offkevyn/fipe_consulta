import 'package:flutter_modular/flutter_modular.dart';

import 'enum/lookup_type_enum.dart';
import 'states/lookup_step_state.dart';
import 'util/type_chosen_lookup.dart';
import 'view/lookup_view.dart';

class LookupModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(TypeChosenLookup.new);
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
