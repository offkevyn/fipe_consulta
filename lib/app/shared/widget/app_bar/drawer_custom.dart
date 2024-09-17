import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/colors_app.dart';
import '../../util/imgs_app.dart';
import '../../util/methods/shared_dialog/shared_dialog.dart';
import '../../util/routes_app.dart';
import '../ink_well_custom/ink_well_custom.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({super.key});

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  late List<_ItemDrawer> listItens;

  late bool _erroLinkOffKevyn;

  @override
  void initState() {
    super.initState();

    listItens = [
      _ItemDrawer(
        name: 'Home',
        icon: const PhosphorIcon(
          PhosphorIconsRegular.houseLine,
          color: ColorsApp.secundary,
          size: 30,
        ),
        onTap: () {
          Modular.to.navigate(RoutesApp.Home);
        },
      ),
      _ItemDrawer(
        name: 'Sair',
        icon: const PhosphorIcon(
          PhosphorIconsRegular.signOut,
          color: ColorsApp.secundary,
          size: 30,
        ),
        onTap: () => SharedDialog.animationDialogModuleConstruction(
          context: context,
        ),
      ),
    ];

    _erroLinkOffKevyn = false;
  }

  void _onTapLinkOffKevyn() async {
    final Uri url = Uri.parse('https://github.com/offkevyn');

    if (!await launchUrl(url)) {
      setState(() {
        _erroLinkOffKevyn = true;
      });
    } else {
      setState(() {
        _erroLinkOffKevyn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsApp.primary,
      width: 270,
      child: Column(
        children: [
          const SizedBox(
            height: 55,
          ),
          const Image(
            image: AssetImage(ImgsApp.logoPng),
            width: 60,
          ),
          const SizedBox(height: 10),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder:
                (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
              if (snapshot.hasError) {
                return const Text('--');
              } else if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              final data = snapshot.data!;
              return Text(
                'V ${data.version}',
                style: const TextStyle(
                  color: ColorsApp.white,
                  fontSize: 14,
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWellCustom(
                onTap: _onTapLinkOffKevyn,
                colorMaterial: Colors.transparent,
                colorInkWell: ColorsApp.primary2.withOpacity(0.5),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text(
                        'offKevyn',
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorsApp.white,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorsApp.white,
                        ),
                      ),
                      SizedBox(width: 1),
                      PhosphorIcon(
                        PhosphorIconsRegular.link,
                        color: ColorsApp.white,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              const Text(
                '© 2024',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorsApp.white,
                ),
              ),
            ],
          ),
          Column(
            children: [
              if (_erroLinkOffKevyn)
                const Text(
                  'Erro ao abrir o link',
                  style: TextStyle(
                    color: ColorsApp.red,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: ((context, index) {
                var itemDrawer = listItens[index];
                return ListTile(
                  minLeadingWidth: 0,
                  leading: itemDrawer.icon,
                  title: Transform.translate(
                    offset: const Offset(-10, 0),
                    child: Text(
                      itemDrawer.name,
                      style: const TextStyle(
                        color: ColorsApp.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  onTap: itemDrawer.onTap,
                );
              }),
              separatorBuilder: (__, _) => const Divider(
                height: 1.5,
                color: ColorsApp.secundary,
              ),
              itemCount: listItens.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemDrawer {
  String name;
  Widget icon;
  void Function() onTap;
  _ItemDrawer({
    required this.name,
    required this.icon,
    required this.onTap,
  });
}
