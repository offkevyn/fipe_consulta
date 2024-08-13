import 'package:flutter/cupertino.dart';

import '../../util/colors_app.dart';

class AppBarTitle extends StatelessWidget {
  final String title;

  const AppBarTitle({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width *
            0.45, // valor máximo para a largura
      ),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: false,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: ColorsApp.white,
        ),
      ),
    );
  }
}
