import 'package:flutter/material.dart';

class AppStyles {
  static const String primaryFont = 'PlusJakartaSans';
  static const String secondaryFont = 'Poppins';

  static TextStyle headingLarge(Color color) => TextStyle(
        fontFamily: primaryFont,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -0.5,
      );

  static TextStyle headingMedium(Color color) => TextStyle(
        fontFamily: primaryFont,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle headingSmall(Color color) => TextStyle(
        fontFamily: primaryFont,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle bodyLarge(Color color) => TextStyle(
        fontFamily: primaryFont,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      );

  static TextStyle bodyMedium(Color color) => TextStyle(
        fontFamily: primaryFont,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle buttonText(Color color) => TextStyle(
        fontFamily: primaryFont,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle caption(Color color) => TextStyle(
        fontFamily: primaryFont,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: color,
      );
}
