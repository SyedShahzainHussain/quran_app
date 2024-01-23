import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:holy_quran_app/firebase_options.dart';
import 'package:holy_quran_app/model/ayah.dart';
import 'package:holy_quran_app/provider/on_board_provider.dart';
import 'package:holy_quran_app/screens/surah_index_screen/viewModel/surah_view_model.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';
import 'package:holy_quran_app/utils/routes/routes.dart';
import 'package:provider/provider.dart';

import 'configs/core_theme.dart';
import 'model/surahs.dart';
import 'provider/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SurahsAdapter());
  Hive.registerAdapter(AyahAdapter());
  await Hive.openBox('data');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => OnBoarddingProvider()),
        ChangeNotifierProvider(create: (context) => SurahViewModel()),
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
