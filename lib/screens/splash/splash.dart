import 'dart:async';

import 'package:flutter/material.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/utils/assets.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../animations/bottom_animation.dart';
import '../../provider/app_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool? isUserOnBoard = sharedPreferences.getBool("onboard") ?? false;
      if (isUserOnBoard) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.home, (route) => false);
      }else{

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
