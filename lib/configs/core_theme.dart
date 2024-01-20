import 'package:flutter/material.dart';

const fontFamily = 'Poppins';

final themeLight = ThemeData(
  fontFamily: fontFamily,
  brightness: Brightness.light,
  dividerColor: Colors.white60,
  splashColor: Colors.transparent,
  useMaterial3: false,
  primaryColor: const Color(0xffee8f8b),
  scaffoldBackgroundColor: Colors.white,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    },
  ),
  colorScheme: ThemeData.light()
      .colorScheme
      .copyWith(
        brightness: Brightness.light,
        background: Colors.white,
      )
      .copyWith(background: Colors.white),
);

final themeDark = ThemeData(
  fontFamily: fontFamily,
  useMaterial3: false,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  dividerColor: Colors.black12,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.grey[850],
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    },
  ),
  colorScheme: ThemeData.light()
      .colorScheme
      .copyWith(
        brightness: Brightness.dark,
        background: const Color(0xFF212121),
      )
      .copyWith(background: const Color(0xFF212121)),
);
