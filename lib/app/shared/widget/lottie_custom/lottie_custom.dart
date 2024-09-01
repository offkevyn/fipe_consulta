import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../util/colors_app.dart';
import '../button_simple/button_simple.dart';

class LottieCustom extends StatefulWidget {
  final LottieType lottieType;
  final void Function()? onPressed;

  const LottieCustom({
    required this.lottieType,
    this.onPressed,
    super.key,
  });

  @override
  State<LottieCustom> createState() => LottieCustomState();
}

class LottieCustomState extends State<LottieCustom> {
  late double height;
  late double width;
  late bool isPortrait;

  late Color colorRed;

  @override
  void initState() {
    super.initState();

    colorRed = ColorsApp.red.withOpacity(0.65);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
    });

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ..._content(lottieType: widget.lottieType),
            if (widget.lottieType == LottieType.failed ||
                widget.lottieType == LottieType.empty)
              Column(
                children: [
                  const SizedBox(height: 35),
                  SizedBox(
                    width: 200,
                    height: 45,
                    child: ButtonSimple(
                      text: 'Tentar novamente',
                      colorBorder: widget.lottieType == LottieType.failed
                          ? colorRed
                          : ColorsApp.primary,
                      colorBackground: Colors.transparent,
                      onPressed: widget.onPressed,
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _content({required LottieType lottieType}) {
    switch (lottieType) {
      case LottieType.empty:
        return [
          SizedBox(
            width: isPortrait ? width * 0.75 : width * 0.4,
            child: Lottie.asset(
              'assets/lottie/empty.json',
              fit: BoxFit.contain,
            ),
          ),
          Text(
            'Nenhum item encontrado',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsApp.primary2.withOpacity(0.6),
            ),
          ),
        ];
      case LottieType.failed:
        return [
          SizedBox(
            width: isPortrait ? width * 0.75 : width * 0.4,
            child: Lottie.asset(
              'assets/lottie/erro.json',
              fit: BoxFit.contain,
            ),
          ),
          Text(
            'Ocorreu um erro!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorRed,
            ),
          ),
        ];
      case LottieType.loading:
        return [
          SizedBox(
            width: isPortrait ? width * 0.55 : width * 0.22,
            child: Lottie.asset(
              'assets/lottie/loading.json',
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            'Carregando...',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: ColorsApp.primary2,
            ),
          ),
        ];
      default:
        return [];
    }
  }
}

enum LottieType { empty, failed, loading }
