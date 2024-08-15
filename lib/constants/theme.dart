import 'package:flutter/material.dart';
import 'package:nitoons/constants/sizes.dart';


class AppTheme {
  ThemeData get light => ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      elevation: 0.0
    ),
      splashColor: Colors.transparent,
      useMaterial3: false,
      highlightColor: Colors.transparent,
      applyElevationOverlayColor: true,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Satoshi',
          color: Colors.black,
          fontSize: TextSizes.textSize24SP,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Satoshi',
          color: Colors.black,
          fontSize: TextSizes.textSize16SP,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Satoshi',
          color: Colors.black,
          fontSize: TextSizes.textSize14SP,
        ),
      ));
}