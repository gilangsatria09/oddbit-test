import 'package:flutter/material.dart';
import 'package:notes_app/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
    ).copyWith(outline: Colors.teal.shade400),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: FontFamily.montserrat,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}
