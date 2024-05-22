import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_fonts.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: kPrimaryColor,
  fontFamily: AppFonts.OUTFIT,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: kPrimaryColor,
  ),
  useMaterial3: false,
  splashColor: kQuaternaryColor.withOpacity(0.10),
  highlightColor: kQuaternaryColor.withOpacity(0.10),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: kQuaternaryColor.withOpacity(0.1),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: kQuaternaryColor,
  ),
);
