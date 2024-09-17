import 'package:flutter_modular/flutter_modular.dart';

import 'views/splash_screen_view.dart';

class SplashScreenModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => const SplashScreenView(),
    );
    r.wildcard(child: (_) => const SplashScreenView());
  }
}
