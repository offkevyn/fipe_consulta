import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../colors_app.dart';
import '../../../lottie_app.dart';

class DialogModuleInConstruction extends StatefulWidget {
  const DialogModuleInConstruction({super.key});

  @override
  State<DialogModuleInConstruction> createState() =>
      _DialogModuleInConstructionState();
}

class _DialogModuleInConstructionState extends State<DialogModuleInConstruction>
    with TickerProviderStateMixin {
  late final AnimationController _animatioControllerInConstruction;

  @override
  void initState() {
    super.initState();
    _animatioControllerInConstruction = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animatioControllerInConstruction.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: ColorsApp.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Text(
        'Em construção!!',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorsApp.primary,
          fontSize: 20.0,
        ),
      ),
      content: Container(
        color: ColorsApp.white,
        child: SizedBox(
          height: 250,
          width: 310,
          child: Center(
            child: Lottie.asset(
              LottieApp.inConstruction,
              controller: _animatioControllerInConstruction,
              onLoaded: (composition) {
                _animatioControllerInConstruction.duration =
                    composition.duration;
                _animatioControllerInConstruction.forward();
                _animatioControllerInConstruction.repeat();
              },
            ),
          ),
        ),
      ),
    );
  }
}
