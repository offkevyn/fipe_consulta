import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../util/colors_app.dart';
import '../../../ink_well_custom/ink_well_custom.dart';

abstract class InfoAppDialog {
  static Future<dynamic> show({
    required BuildContext context,
  }) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: const _DialogContent(),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent();

  @override
  Widget build(BuildContext context) {
    void onTapLink({required String link}) async {
      final Uri url = Uri.parse(link);

      if (!await launchUrl(url)) {
        // setState(() {
        //   _erroLink = true;
        // });
      } else {
        // setState(() {
        //   _erroLink = false;
        // });
      }
    }

    Widget infoDialog({
      required String title,
      required String value,
      String? link,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: const TextStyle(
              color: ColorsApp.primary,
              fontWeight: FontWeight.w600,
              fontSize: 17.0,
              height: 0.9,
            ),
          ),
          link == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '- $value',
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              color: ColorsApp.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0,
                              height: 0.9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : InkWellCustom(
                  onTap: () => onTapLink(link: link),
                  colorMaterial: Colors.transparent,
                  colorInkWell: ColorsApp.primary2.withOpacity(0.1),
                  child: Container(
                    width: 130,
                    padding: const EdgeInsets.all(5.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Clique Aqui',
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorsApp.primary,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorsApp.primary,
                          ),
                        ),
                        SizedBox(width: 4),
                        PhosphorIcon(
                          PhosphorIconsRegular.link,
                          color: ColorsApp.primary,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
          const SizedBox(height: 15),
        ],
      );
    }

    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: Container(
        color: Colors.white,
        height: 250,
        width: 310,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'FIPE CONSULTA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorsApp.primary2,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.5,
                  ),
                ),
              ),
              const Center(
                child: PhosphorIcon(
                  PhosphorIconsRegular.info,
                  color: ColorsApp.secundary,
                  size: 50,
                ),
              ),
              infoDialog(
                title: 'App',
                value:
                    'Este é um aplicativo simples feito com o intuito de aprender animação no Flutter.',
              ),
              infoDialog(
                title: 'Link do projeto no GitHub',
                value: 'Link do projeto: ',
                link: 'https://github.com/offkevyn/fipe_consulta',
              ),
              infoDialog(
                title: 'Crédito ao desenvolvedor da API',
                value: 'Deivid Fortuna',
                link: 'https://deividfortuna.github.io/fipe/',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
