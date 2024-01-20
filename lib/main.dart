import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holy_quran_app/provider/on_board_provider.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';
import 'package:holy_quran_app/utils/routes/routes.dart';
import 'package:provider/provider.dart';

import 'configs/core_theme.dart';
import 'provider/app_provider.dart';
import 'screens/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => OnBoarddingProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, value, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: value.themeMode,
          theme: themeLight,
          darkTheme: themeDark,
          initialRoute: RouteName.splash,
          onGenerateRoute: AppRoutes.onGenrateRoute,
        ),
      ),
    );
  }
}
