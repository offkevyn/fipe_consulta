import 'package:flutter/cupertino.dart';

import '../../../../shared/util/colors_app.dart';

class LookupStepOne extends StatefulWidget {
  const LookupStepOne({super.key});

  @override
  State<LookupStepOne> createState() => _LookupStepOneState();
}

class _LookupStepOneState extends State<LookupStepOne> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Step One',
        style: TextStyle(
          fontSize: 20,
          color: ColorsApp.primary,
        ),
      ),
    );
  }
}
