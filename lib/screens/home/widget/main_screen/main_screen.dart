import 'package:flutter/material.dart';
import 'package:holy_quran_app/animations/bottom_animation.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/screens/onboarding/widget/app/app_button.dart';
import 'package:holy_quran_app/screens/onboarding/widget/app/app_name.dart';
import 'package:holy_quran_app/screens/onboarding/widget/app/bottom_text.dart';
import 'package:holy_quran_app/screens/onboarding/widget/app/rahel.dart';
import 'package:holy_quran_app/utils/assets.dart';
import 'package:provider/provider.dart';

import '../../../onboarding/widget/app/app_logo.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
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
                  AppButton(onPressed: () {}, title: "Surah Index"),
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
