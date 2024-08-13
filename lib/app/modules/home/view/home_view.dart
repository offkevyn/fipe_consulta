import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/util/colors_app.dart';
import '../../../shared/util/lottie_app.dart';
import '../../../shared/widget/app_bar/drawer_custom.dart';
import '../widget/app_bar_home_custom/app_bar_home_custom.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final AnimationController _animatioControllerSpeedometer;

  @override
  void initState() {
    super.initState();
    _animatioControllerSpeedometer = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animatioControllerSpeedometer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCustom(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: ColorsApp.backgroundGradient,
        ),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: AppBarHomeCustom(),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 90,
                    decoration: const BoxDecoration(
                        color: ColorsApp.primary,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(50),
                        )),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 80,
                        child: Lottie.asset(
                          LottieApp.speedometer,
                          controller: _animatioControllerSpeedometer,
                          onLoaded: (composition) {
                            _animatioControllerSpeedometer.duration =
                                composition.duration;
                            _animatioControllerSpeedometer.forward();
                            _animatioControllerSpeedometer.repeat();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
