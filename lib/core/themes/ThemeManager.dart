import 'package:flutter/material.dart';
import 'package:newsapp/core/themes/ColorPalette.dart';

abstract class ThemeManager {
  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ColorPalette.white,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        foregroundColor: ColorPalette.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: "inter",
          fontSize: 20,
          color: ColorPalette.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      drawerTheme: DrawerThemeData(),
      textTheme: TextTheme(
        headlineSmall: TextStyle(
          fontFamily: "inter",
          fontWeight: FontWeight.w500,
          fontSize: 24,
          color: ColorPalette.black,
        ),
          headlineMedium:TextStyle(
            fontSize: 30,
            fontFamily: "inter",
            fontWeight: FontWeight.w400,
              color: ColorPalette.white
          ),
          titleLarge:TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: "inter",
            color: ColorPalette.white
          ),
          titleMedium:TextStyle(
            fontSize: 16,
            fontFamily: "inter",
            fontWeight: FontWeight.w700,
            color:ColorPalette.black
          ),
          titleSmall:TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: "inter",
            color: ColorPalette.black
          ),
          bodySmall:TextStyle(
            fontSize: 12,
            fontFamily: "inter",
            fontWeight: FontWeight.w500,
            color:ColorPalette.grey
          )
      ),
    );
  }
}
