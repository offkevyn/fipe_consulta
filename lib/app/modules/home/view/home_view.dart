import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../shared/util/colors_app.dart';
import '../../../shared/util/lottie_app.dart';
import '../../../shared/util/routes_app.dart';
import '../../../shared/widget/app_bar/drawer_custom.dart';
import '../../lookup/enum/lookup_type_enum.dart';
import '../widget/app_bar_home_custom/app_bar_home_custom.dart';
import '../widget/item_home/item_home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final AnimationController _animatioControllerSpeedometer;
  late final List<ItemHome> _itens;

  @override
  void initState() {
    super.initState();
    _animatioControllerSpeedometer = AnimationController(vsync: this);

    _itens = [
      ItemHome(
        name: 'Carros',
        onTap: () {
          Modular.to.pushNamed('${RoutesApp.Lookup}/', arguments: {
            'lookupType': LookupTypeEnum.car,
          });
        },
        icon: const PhosphorIcon(
          PhosphorIconsRegular.carProfile,
          color: ColorsApp.secundary,
          size: 90,
        ),
      ),
      ItemHome(
        name: 'Motos',
        inConstruction: true,
        onTap: () {},
        icon: const PhosphorIcon(
          PhosphorIconsRegular.motorcycle,
          color: ColorsApp.secundary,
          size: 90,
        ),
      ),
    ];
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
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 25,
                      runSpacing: 25,
                      children: _itens,
                    ),
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
