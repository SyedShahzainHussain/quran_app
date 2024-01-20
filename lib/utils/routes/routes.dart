import 'package:flutter/material.dart';
import 'package:holy_quran_app/screens/home/home_screen.dart';
import 'package:holy_quran_app/screens/onboarding/onboarding.dart';
import 'package:holy_quran_app/screens/splash/splash.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';

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
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text("No Routes Defined")),
                ));
    }
  }
}
