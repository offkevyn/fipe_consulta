import 'package:flutter_modular/flutter_modular.dart';

import 'state/app_initialization_state.dart';
import 'views/splash_screen_view.dart';

class SplashScreenModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(AppInitializationState.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => const SplashScreenView(),
    );
    r.wildcard(child: (_) => const SplashScreenView());
  }
}
