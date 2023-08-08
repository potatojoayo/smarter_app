import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarter/app/global/utils/create_material_color.dart';

// const primaryColor = Color(0xFF458BEA);
const primaryColor = Color(0xFF619FF8);
const backgroundColor = Color(0xFFFFFFFF);
const errorColor = Color(0xFFF75555);
const successColor = Color(0xFF6a994e);
final cardColor = Colors.grey[200];
const textColor = Color(0xFF4C4C4C);
const textLight = Color(0xFFA2A1A1);
final greyColor = Colors.grey[200];
const disabledColor = Color(0xFFA2A1A1);
const focusColor = Color(0xFFF75555);
final newColor = Colors.red[50];

final appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundColor,
    elevation: 0,
    titleSpacing: 0,
    iconTheme: IconThemeData(
      color: textColor,
      size: 20,
    ),
    scrolledUnderElevation: 0,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: textColor),
    ),
  ),
  disabledColor: disabledColor,
  primaryColor: primaryColor,
  checkboxTheme: CheckboxThemeData(checkColor: MaterialStateProperty.resolveWith((states) =>Colors.white )),
  cardTheme: CardTheme(color: cardColor, elevation: 0),
  focusColor: focusColor,
  // dividerColor: Colors.grey.shade100,
  dividerTheme: DividerThemeData(color:Colors.grey.shade200 ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateColor.resolveWith((_) => Colors.transparent),
      backgroundColor: MaterialStateColor.resolveWith((_) => Colors.white),
    ),
  ),
  iconTheme: const IconThemeData(
    color: textColor,
    size: 35,
  ),
  scaffoldBackgroundColor: backgroundColor,
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.grey),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.grey[50],
      backgroundColor: primaryColor,
      minimumSize: const Size(0, 50),
      textStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 15,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  textTheme: GoogleFonts.ibmPlexSansKrTextTheme(
    const TextTheme(
      displayLarge: TextStyle(
          color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          color: primaryColor, fontSize: 25, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 23,
        decoration: TextDecoration.underline,
      ),
      headlineLarge: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 30,
        decoration: TextDecoration.underline,
      ),
      titleLarge: TextStyle(
          color: textColor, fontSize: 30, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          color: textColor, fontSize: 27, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(
          color: textColor, fontSize: 25, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(
          color: textColor, fontSize: 23, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
          color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(
          color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
        color: textColor,
        fontSize: 13,
      ),
      labelSmall: TextStyle(
          color: textLight, fontSize: 13, fontWeight: FontWeight.bold),
    ),
  ),
  colorScheme:
      ColorScheme.fromSwatch(primarySwatch: createMaterialColor(primaryColor))
          .copyWith(background: backgroundColor)
          .copyWith(error: errorColor),
);
