import 'package:flutter_modular/flutter_modular.dart';

import 'enum/lookup_type_enum.dart';
import 'view/lookup_view.dart';

class LookupModule extends Module {
  @override
  void binds(i) {}

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
