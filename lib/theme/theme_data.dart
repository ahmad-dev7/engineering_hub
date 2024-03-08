import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  //! Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFFEBEBEB),
    cardColor: Colors.blue[500],
    colorScheme: ColorScheme.light(
      primaryContainer: const Color(0xFF7DBBAE),
      secondaryContainer: Colors.white,
      tertiaryContainer: Colors.blueGrey.shade300,
    ),
    iconTheme: const IconThemeData(color: Color(0xFF45827E)),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionHandleColor: Color(0xFFBBE0FF),
    ),
    splashColor: Colors.grey.shade600,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      linearTrackColor: Colors.greenAccent[300],
      circularTrackColor: Colors.greenAccent[300],
      color: Colors.greenAccent[300],
      refreshBackgroundColor: Colors.greenAccent,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  );

  //! Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.grey.shade900,
    cardColor: Colors.blueGrey[900],
    colorScheme: ColorScheme.dark(
      primaryContainer: const Color(0xFF1e3c37),
      secondaryContainer: Colors.white70,
      tertiaryContainer: Colors.grey.shade900,
    ),
    iconTheme: IconThemeData(color: Colors.grey.shade400),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionHandleColor: Color(0xFF546A74),
    ),
    splashColor: Colors.grey.shade600,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      linearTrackColor: Color(0xFF49B380),
      circularTrackColor: Color(0xFF49B380),
      color: Color(0xFF49B380),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  );
}
