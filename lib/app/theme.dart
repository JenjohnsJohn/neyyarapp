import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFF673AB7), // Deep Purple (Material Design)
  hintColor: Color(0xFF9575CD), // Light Purple (Material Design)
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto', // Or your preferred font

  textTheme: TextTheme(
    titleSmall: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold), // For section titles
    bodyMedium: TextStyle(fontSize: 16.0), // For body text
    // ... Add other text styles as needed
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF673AB7), // Match the primary color
    elevation: 0, // Remove shadow
    centerTitle: true, // Center the title
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF673AB7),
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontSize: 16.0),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  ),

  // Add other theme customizations as needed (e.g., input decoration, card theme, bottom navigation bar theme)
);
