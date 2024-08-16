import 'package:fipe_consulta/app/shared/util/helper/string_helper.dart';
import 'package:flutter/material.dart';

import '../enum/lookup_type_enum.dart';

class LookupView extends StatefulWidget {
  final LookupTypeEnum lookupType;

  const LookupView({
    this.lookupType = LookupTypeEnum.car,
    super.key,
  });

  @override
  State<LookupView> createState() => _LookupViewState();
}

class _LookupViewState extends State<LookupView> {
  late LookupTypeEnum _lookupType;

  @override
  void initState() {
    super.initState();

    _lookupType = widget.lookupType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Lookup ${_lookupType.value.formatter(capitalize: true)}'),
      ),
    );
  }
}
