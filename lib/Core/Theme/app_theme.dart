// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:techshop_app/Core/Theme/text_theme.dart';

class MyAppTheme {
  MyAppTheme._();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 162, 95, 230),
      brightness: Brightness.dark,
    ),
    primaryColor: const Color.fromARGB(255, 162, 95, 230),
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: const Color.fromRGBO(29, 24, 42, 100),
    textTheme: MyTextTheme.darkTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 162, 95, 230),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 162, 95, 230),
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.white,
    ),
  );

  // static ThemeData lightTheme = ThemeData(
  //   useMaterial3: true,
  //   appBarTheme: const AppBarTheme(
  //     elevation: 0,
  //     scrolledUnderElevation: 0,
  //     backgroundColor: Colors.transparent,
  //     surfaceTintColor: Colors.transparent,
  //     centerTitle: true,
  //     titleTextStyle: TextStyle(
  //       fontSize: 20,
  //       color: Colors.black,
  //       fontWeight: FontWeight.w600,
  //     ),
  //   ),
  //   colorScheme: ColorScheme.fromSeed(
  //     seedColor: const Color.fromARGB(255, 162, 95, 230),
  //     brightness: Brightness.light,
  //   ),
  //   primaryColor: const Color.fromARGB(255, 162, 95, 230),
  //   brightness: Brightness.light,
  //   fontFamily: 'Poppins',
  //   scaffoldBackgroundColor: const Color.fromARGB(1, 235, 235, 235),
  //   textTheme: MyTextTheme.lightTheme,
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //         backgroundColor: const Color.fromARGB(255, 162, 95, 230),
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
  //   ),
  // );
}
