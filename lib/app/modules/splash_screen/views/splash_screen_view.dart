import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/util/colors_app.dart';
import '../../../shared/util/imgs_app.dart';
import '../../../shared/util/routes_app.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  late double _heightImage;
  late double _height;

  late double _topPosition;
  late double _opacityImg;

  late int _durationAnimation;
  late bool _initializedAnimation;

  @override
  void initState() {
    super.initState();

    _topPosition = -150;
    _opacityImg = 0.0;

    _durationAnimation = 2200;
    _initializedAnimation = false;
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
      Modular.to.navigate(
        RoutesApp.Home,
      );
    });

    // Future.delayed(Duration(milliseconds: _durationAnimation + 500), () {
    //   setState(() {
    //     _topPosition = _height + _heightImage;
    //     _opacityImg = 0.1;
    //   });
    // });

    // Future.delayed(Duration(milliseconds: _durationAnimation * 2 - 200), () {
    //   Modular.to.navigate(
    //     RoutesApp.Home,
    //   );
    // });
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
          ],
        ),
      ),
    );
  }
}
