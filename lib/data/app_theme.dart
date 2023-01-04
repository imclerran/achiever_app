import 'package:flutter/material.dart';

class AppTheme {
  Brightness brightness;
  AppTheme(this.brightness);

  Color get primaryColor => Brightness.light == brightness
      ? AppThemeLight.primaryColor
      : AppThemeDark.primaryColor;
  Color get accentColor => Brightness.light == brightness
      ? AppThemeLight.accentColor
      : AppThemeDark.accentColor;
  Color get accentColor2 => Brightness.light == brightness
      ? AppThemeLight.accentColor2
      : AppThemeDark.accentColor2;
  Color get cardColor => Brightness.light == brightness
      ? AppThemeLight.cardColor
      : AppThemeDark.cardColor;
  Color get cardColor2 => Brightness.light == brightness
      ? AppThemeLight.cardColor2
      : AppThemeDark.cardColor2;
  Color get shadowColor => Brightness.light == brightness
      ? AppThemeLight.shadowColor
      : AppThemeDark.shadowColor;
  Color get backgroundColor => Brightness.light == brightness
      ? AppThemeLight.backgroundColor
      : AppThemeDark.backgroundColor;
  Color get disabledColor => Brightness.light == brightness
      ? AppThemeLight.disabledColor
      : AppThemeDark.disabledColor;
  Color get highlightColor => Brightness.light == brightness
      ? AppThemeLight.highlightColor
      : AppThemeDark.highlightColor;
  Color get okayColor => Brightness.light == brightness
      ? AppThemeLight.okayColor
      : AppThemeDark.okayColor;
  Color get warningColor => Brightness.light == brightness
      ? AppThemeLight.warningColor
      : AppThemeDark.warningColor;
  Color get errorColor => Brightness.light == brightness
      ? AppThemeLight.errorColor
      : AppThemeDark.errorColor;

  TextStyle get h1 =>
      Brightness.light == brightness ? AppThemeLight.h1 : AppThemeDark.h1;
  TextStyle get h2 =>
      Brightness.light == brightness ? AppThemeLight.h2 : AppThemeDark.h2;
  TextStyle get h3 =>
      Brightness.light == brightness ? AppThemeLight.h3 : AppThemeDark.h3;
  TextStyle get h4 =>
      Brightness.light == brightness ? AppThemeLight.h4 : AppThemeDark.h4;
  TextStyle get h5 =>
      Brightness.light == brightness ? AppThemeLight.h5 : AppThemeDark.h5;
  TextStyle get h6 =>
      Brightness.light == brightness ? AppThemeLight.h6 : AppThemeDark.h6;
  TextStyle get text =>
      Brightness.light == brightness ? AppThemeLight.text : AppThemeDark.text;
  TextStyle get textAccent => Brightness.light == brightness
      ? AppThemeLight.textAccent
      : AppThemeDark.textAccent;
  TextStyle get subtext => Brightness.light == brightness
      ? AppThemeLight.subtext
      : AppThemeDark.subtext;

  double get cardRadius => 10.0;
}

class AppThemeLight {
  // Colors:
  static Color backgroundColor = Colors.grey[100];
  static Color shadowColor = Colors.black12;
  static Color primaryColor = Colors.white;
  static Color cardColor = Colors.white;
  static Color cardColor2 = Colors.grey[200];
  static Color disabledColor = Colors.grey[350];
  static Color accentColor = Colors.lightBlueAccent;
  static Color accentColor2 = Colors.tealAccent[200];
  static Color highlightColor = Colors.white;
  static Color okayColor = Colors.tealAccent[700];
  static Color warningColor = Colors.orangeAccent;
  static Color errorColor = Colors.red[400];

  static double iconSizeLarge = 32;
  static double iconSizeMedium = 22;
  static double iconSizeSmall = 18;

  // TextStyles:
  static TextStyle h1 = TextStyle(
    //fontSize: 40,
    fontSize: 36,
    color: Colors.black38,
    fontWeight: FontWeight.w300,
  );
  static TextStyle h2 = TextStyle(
    //fontSize: 32,
    fontSize: 32,
    color: Colors.black38,
    fontWeight: FontWeight.w300,
  );
  static TextStyle h3 = TextStyle(
    color: accentColor,
    //fontSize: 24,
    fontSize: 20,
    fontWeight: FontWeight.bold, //w500
  );
  static TextStyle h4 = TextStyle(
    //fontSize: 22,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black54,
  );
  static TextStyle h5 = TextStyle(
    //fontSize: 18,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black54,
  );
  static TextStyle h6 = TextStyle(
    //fontSize: 18,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black45,
  );
  static TextStyle text = TextStyle(
    color: Colors.black45,
    fontWeight: FontWeight.w500,
    //fontSize: 16,
    fontSize: 14,
  );
  static TextStyle textAccent = TextStyle(
    color: accentColor,
    fontWeight: FontWeight.w500,
    //fontSize: 16,
    fontSize: 14,
  );
  static TextStyle subtext = TextStyle(
    color: Colors.black45,
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );
}

class AppThemeDark {
  // Colors:
  static Color primaryColor = Colors.grey[850];
  static Color cardColor = Colors.grey[850];
  static Color cardColor2 = Colors.grey[900];
  static Color disabledColor = Colors.grey[700];
  static Color accentColor = Colors.lightBlueAccent;
  static Color accentColor2 = Colors.tealAccent[200];
  static Color backgroundColor = Colors.grey[900];
  static Color shadowColor = Colors.black;
  static Color highlightColor = Colors.grey[800];
  static Color okayColor = Colors.tealAccent[200];
  static Color warningColor = Colors.orange[300];
  static Color errorColor = Colors.red[300];

  static double iconSizeLarge = 32;
  static double iconSizeMedium = 22;
  static double iconSizeSmall = 18;

  // TextStyles:
  static TextStyle h1 = TextStyle(
    //fontSize: 40,
    fontSize: 36,
    color: Colors.grey[400],
    fontWeight: FontWeight.w300,
  );
  static TextStyle h2 = TextStyle(
    //fontSize: 32,
    fontSize: 32,
    color: Colors.grey[400],
    fontWeight: FontWeight.w300,
  );
  static TextStyle h3 = TextStyle(
    color: accentColor,
    //fontSize: 24,
    fontSize: 20,
    fontWeight: FontWeight.bold, //w500
  );
  static TextStyle h4 = TextStyle(
    //fontSize: 22,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.grey[100],
  );
  static TextStyle h5 = TextStyle(
    //fontSize: 18,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.grey[100],
  );
  static TextStyle h6 = TextStyle(
    //fontSize: 18,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.grey[300],
  );
  static TextStyle text = TextStyle(
    color: Colors.grey[300],
    fontWeight: FontWeight.w500,
    //fontSize: 16,
    fontSize: 14,
  );
  static TextStyle textAccent = TextStyle(
    color: accentColor,
    fontWeight: FontWeight.w500,
    //fontSize: 16,
    fontSize: 14,
  );
  static TextStyle subtext = TextStyle(
    color: Colors.grey[300],
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );
}
