import 'package:flutter/material.dart';
import 'package:holy_quran_app/app_links/app_links.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/screens/home/widget/app/app_button.dart';
import 'package:holy_quran_app/screens/home/widget/app/app_name.dart';
import 'package:holy_quran_app/screens/home/widget/app/bottom_text.dart';
import 'package:holy_quran_app/screens/home/widget/app/rahel.dart';
import 'package:provider/provider.dart';

import '../app/app_logo.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Material(
      child: Container(
        width: context.screenheight,
        color: appProvider.isDark ? Colors.grey[850] : Colors.white,
        child: SafeArea(
            child: Stack(
          fit: StackFit.expand,
          children: [
            const AppName(),
            const AppLogo(),
            const Rahel(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                      onPressed: () {
                        AppLinks().createLink();
                      },
                      title: "Surah Index"),
                  AppButton(onPressed: () {}, title: "Juzz Index"),
                  AppButton(onPressed: () {}, title: "Bookmarks"),
                ],
              ),
            ),
            const BottomText()
          ],
        )),
      ),
    );
  }
}
