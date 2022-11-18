import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF003566),
      secondary: Color(0xFF003566),
      onPrimary: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF000814),
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),

      // focusedBorder:
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Colors.white));

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: "Montserrat",
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF001D3D),
    secondary: Color(0xFF003566),
    surface: Color(0xFFFFD60A),
    onSurface: Colors.white,
    onPrimary: Colors.white,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color(0xFF000814),
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color(0xFF000814),
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color(0xFF000814),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xFF003566)),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
      alignLabelWithHint: true,
      hintStyle: TextStyle(
        fontFamily: "RobotoMono",
        fontWeight: FontWeight.w800,
        fontSize: 15,
      )),
);
