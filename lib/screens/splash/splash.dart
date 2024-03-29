import 'dart:async';

import 'package:flutter/material.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/screens/juz_screen/view_model/juzz_view_model.dart';
import 'package:holy_quran_app/utils/assets.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../animations/bottom_animation.dart';
import '../../global/global.dart';
import '../../provider/app_provider.dart';
import 'package:holy_quran_app/screens/surah_index_screen/viewModel/surah_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  JuzzViewModel juzzViewModel2 = JuzzViewModel();
  SurahViewModel surahViewModel3 = SurahViewModel();
  void storeAllJuzzToLocalDataBase() {
    for (var i = 1; i <= 30; i++) {
      cache.get("juz$i") ?? juzzViewModel2.juzzApi(i);
    }
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () async {
      cache.get("surahs") ?? await surahViewModel3.surahsApi();
      storeAllJuzzToLocalDataBase();

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool? isUserOnBoard = sharedPreferences.getBool("onboard") ?? false;
      if (isUserOnBoard) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.home, (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, RouteName.onboard);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: appProvider.isDark ? Colors.grey[850] : Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetAnimation(
              child: Image.asset(
                appProvider.isDark ? StaticAssets.gradLogo : StaticAssets.logo,
                height: context.screenheight * .5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
