import 'package:flutter/material.dart';
import 'package:holy_quran_app/model/surah/surah_model.dart';
import 'package:holy_quran_app/screens/home/home_screen.dart';
import 'package:holy_quran_app/screens/juz_screen/page_screen/juzz_page_screen.dart';
import 'package:holy_quran_app/screens/onboarding/onboarding.dart';
import 'package:holy_quran_app/screens/surah_index_screen/page_screen/page_screen.dart';
import 'package:holy_quran_app/screens/surah_index_screen/page_screen/page_screen2.dart';
import 'package:holy_quran_app/screens/share/share_screen.dart';
import 'package:holy_quran_app/screens/splash/splash.dart';
import 'package:holy_quran_app/screens/surah_index_screen/surah_index_screen.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';
import 'package:holy_quran_app/model/surah/surahs.dart' as hive;

import '../../screens/juz_screen/juz_screen_index.dart';

class AppRoutes {
  static Route<dynamic> onGenrateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteName.onboard:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case RouteName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteName.share:
        return MaterialPageRoute(builder: (context) => const ShareScreen());
      case RouteName.surah:
        return MaterialPageRoute(
          builder: (context) => const SurahIndexScreen(),
        );
      case RouteName.page:
        return MaterialPageRoute(
          builder: (context) => PageScreen(
            surahs: routeSettings.arguments as Surahs,
          ),
        );
      case RouteName.page2:
        return MaterialPageRoute(
          builder: (context) => PageScreen2(
            surahs: routeSettings.arguments as hive.Surahs,
          ),
        );
      case RouteName.juz:
        return MaterialPageRoute(
          builder: (context) => const JuzIndexScreen(),
        );
      case RouteName.juzPage:
        return MaterialPageRoute(
          builder: (context) =>
              JuzzPageScreen(juzzIndex: routeSettings.arguments as int),
        );

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text("No Routes Defined")),
                ));
    }
  }
}
