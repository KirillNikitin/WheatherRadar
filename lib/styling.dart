import 'package:flutter/material.dart';

class AppColors {
  static Color bgWhite = Colors.white; // #FFFFFF
  static Color bgBlue = const Color.fromRGBO(0, 165, 229, 1); // #00A5E5
  static Color bgLightBlue = const Color.fromRGBO(229, 246, 253, 1); // #E5F6FD
  static Color bgGray = const Color.fromRGBO(248, 249, 250, 1); // #F8F9FA

  static Color fontDark = const Color.fromRGBO(38, 38, 38, 1); // #262626
  static Color fontLight = const Color.fromRGBO(112, 117, 122, 1); // #70757A

  static Color borderColor = const Color.fromRGBO(230, 230, 230, 1); // #E6E6E6
}

// Text Styles
TextStyle xxlTextStyle = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.normal,
    color: AppColors.fontDark); // 26pt
TextStyle xlTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.normal,
    color: AppColors.fontDark); // 23pt
TextStyle largeTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.normal,
    color: AppColors.fontDark); // 19pt
TextStyle biggerTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.fontLight); // 15pt
TextStyle mediumTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.fontLight); // 13pt
TextStyle smallTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.fontLight); // 10pt

// Naming
final String titleTextENG = 'Weather radar'; // can be used with localization
final String titleTextFIN = 'Säätutka'; // can be used with localization
final String windStr = 'Wind';
final String humidityStr = 'Humidity';
final String precipitationStr = 'Precipitation';

// Signs
final String celciumDegSign = '° C';
final String metersPerSecondSign = 'm/s';
final String percentSign = '%';
final String precipitationSign = 'mm';
final String slotDeltaSign = '(3 h)';

// Margins, Paddings, Border radius
final double xxlPadding = 56;
final double xlPadding = 48;
final double lPadding = 34;
final double mPadding = 25;
final double sPadding = 15;
final double xsPadding = 8;
final double xxsPadding = 4;

final double borderRadius = 8;
