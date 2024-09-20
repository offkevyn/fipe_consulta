import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/util/colors_app.dart';
import '../../../shared/util/imgs_app.dart';
import '../../../shared/util/lottie_app.dart';
import '../../../shared/util/routes_app.dart';
import '../state/app_initialization_state.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  late AppInitializationState _appInitializationState;

  late double _heightImage;
  late double _height;

  late double _topPosition;
  late double _opacityImg;

  late int _durationAnimation;
  late bool _initializedAnimation;

  late String _currentStep;

  late bool _animationFinished;

  @override
  void initState() {
    super.initState();

    _appInitializationState = Modular.get();

    _currentStep = '';

    _animationFinished = false;

    _appInitializationState.currentStep.addListener(() {
      _listenerCurrentStep();
    });

    _appInitializationState.state.addListener(() {
      _listenerState();
    });

    _appInitializationState.initialize();

    _topPosition = -150;
    _opacityImg = 0.0;

    _durationAnimation = 2200;
    _initializedAnimation = false;
  }

  @override
  void dispose() {
    _appInitializationState.currentStep.removeListener(() {});
    _appInitializationState.state.removeListener(() {});

    super.dispose();
  }

  void _startAnimation() {
    _initializedAnimation = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _topPosition = (_height / 2) - (_heightImage / 2);
        _opacityImg = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: _durationAnimation + 300), () {
      _animationFinished = true;
      if (_appInitializationState.state.value ==
          AppInitializationTypeState.finished) {
        Modular.to.navigate(
          RoutesApp.Home,
        );
      }
    });
  }

  void _listenerCurrentStep() {
    setState(() {
      _currentStep = _appInitializationState.currentStep.value.name;
    });
  }

  void _listenerState() {
    if (_appInitializationState.state.value ==
            AppInitializationTypeState.finished &&
        _animationFinished) {
      Modular.to.navigate(
        RoutesApp.Home,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;

    _heightImage = _height * 0.25;
    if (_heightImage > 350) _heightImage = 350;

    if (!_initializedAnimation) _startAnimation();

    return Container(
      color: ColorsApp.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedPositioned(
              duration: Duration(milliseconds: _durationAnimation),
              curve: Curves.bounceOut,
              top: _topPosition,
              right: 0,
              left: 0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: _durationAnimation),
                curve: Curves.bounceOut,
                opacity: _opacityImg,
                child: Image.asset(
                  ImgsApp.logoPng,
                  fit: BoxFit.contain,
                  height: _heightImage,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Column(
                children: [
                  Text(
                    _currentStep,
                    style: const TextStyle(
                      color: ColorsApp.white,
                      fontSize: 13,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 9,
                    child: Lottie.asset(
                      LottieApp.loadingDot,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
