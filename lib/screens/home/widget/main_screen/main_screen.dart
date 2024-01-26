import 'package:flutter/material.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/screens/home/widget/app/app_button.dart';
import 'package:holy_quran_app/screens/home/widget/app/app_name.dart';
import 'package:holy_quran_app/screens/home/widget/app/bottom_text.dart';
import 'package:holy_quran_app/screens/home/widget/app/rahel.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';
import 'package:holy_quran_app/widget/flare.dart';
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
                        Navigator.pushNamed(context, RouteName.surah);
                      },
                      title: "Surah Index"),
                  AppButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteName.juz);
                      },
                      title: "Juzz Index"),
                  AppButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteName.bookMark);
                      },
                      title: "Bookmarks"),
                ],
              ),
            ),
            const BottomText(),
            if (appProvider.isDark) ...[
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(context.screenwidth, -context.screenheight),
                bottom: -50,
                flareDuration: const Duration(seconds: 17),
                left: 100,
                height: 60,
                width: 60,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(context.screenwidth, -context.screenheight),
                bottom: -50,
                flareDuration: const Duration(seconds: 17),
                left: 10,
                height: 40,
                width: 40,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(context.screenwidth, -context.screenheight),
                bottom: -40,
                flareDuration: const Duration(seconds: 17),
                left: -100,
                height: 50,
                width: 50,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(context.screenwidth, -context.screenheight),
                bottom: -20,
                flareDuration: const Duration(seconds: 17),
                left: -80,
                height: 20,
                width: 20,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(context.screenwidth, -context.screenheight),
                bottom: -120,
                flareDuration: const Duration(seconds: 17),
                left: -80,
                height: 20,
                width: 20,
              ),
            ]
          ],
        )),
      ),
    );
  }
}
