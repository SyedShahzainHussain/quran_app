import 'package:flutter/material.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/utils/assets.dart';
import 'package:holy_quran_app/utils/drawer_utils.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return SizedBox(
      height: context.screenheight,
      width: context.screenwidth * 0.835,
      child: SafeArea(
        child: Material(
          color: appProvider.isDark ? Colors.grey[850] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\nThe",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: context.screenheight * 0.025,
                            color: appProvider.isDark
                                ? Colors.grey[200]
                                : Colors.black54,
                          ),
                        ),
                        Text(
                          "Holy\nQur'an",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appProvider.isDark
                                ? Colors.grey[200]
                                : Colors.black54,
                            fontSize: context.screenheight * 0.035,
                          ),
                        )
                      ],
                    ),
                    Image.asset(
                      StaticAssets.gradLogo,
                      height: context.screenheight * 0.17,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ...DrawerUtils.item
                    .map((e) => Card(
                          color: appProvider.isDark
                              ? Colors.grey[800]
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, e["route"]);
                            },
                            leading: Icon(
                              e["icon"],
                            ),
                            title: Text(e["title"]),
                          ),
                        ))
                    .toList(),
                Consumer<AppProvider>(
                  builder: (context, value, _) => Card(
                    color: appProvider.isDark ? Colors.grey[800] : Colors.white,
                    child: ListTile(
                      onTap: () {},
                      trailing: Transform.scale(
                        scale: 1.2,
                        child: Switch(
                            activeColor: Colors.white,
                            value: value.isDark,
                            activeTrackColor: appProvider.isDark
                                ? Colors.white
                                : Colors.grey[800],
                            onChanged: (value2) {
                              if (value2) {
                                value.setTheme(ThemeMode.dark);
                              } else {
                                value.setTheme(ThemeMode.light);
                              }
                            }),
                      ),
                      leading: const Icon(
                        Icons.dark_mode,
                      ),
                      title: const Text("Dark Mode"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
