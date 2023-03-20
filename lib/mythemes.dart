import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(),
      primaryColor: Colors.green.shade100,
      appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade700));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(),
      primaryColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.amber.shade700,
      ));
}
