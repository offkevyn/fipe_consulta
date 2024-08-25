import 'package:flutter/cupertino.dart';

import '../../../../../shared/util/colors_app.dart';

class LookupStepTwo extends StatefulWidget {
  const LookupStepTwo({super.key});

  @override
  State<LookupStepTwo> createState() => _LookupStepTwoState();
}

class _LookupStepTwoState extends State<LookupStepTwo> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Step Two',
        style: TextStyle(
          fontSize: 20,
          color: ColorsApp.primary,
        ),
      ),
    );
  }
}
