import 'package:flutter/material.dart';

class AppColor extends ChangeNotifier {
  AppColor();

  static Color colorPrimary = const Color(0xFF101010);
  static Color colorPrimaryDark = const Color(0xFF004B81);
  static Color colorBackground = const Color(0xFF222222);
  static Color colorAppBarDark = const Color(0xFF2a2a2a);
  static Color colorPrimaryButton = const Color(0xFFF3C74C);
  static Color colorBlack = const Color(0xFF000016);
  static Color colorDarkGray = const Color(0xFFEEEEEE);
  static Color colorItemDarkWhite = const Color(0xFF333333);
  static Color colorWhiteDark = Colors.white;
  static Color colorWhiteDarkHeader = Colors.black;
  static Color colorDivider = const Color(0xFF101010);
  static Color colorWhiteGrey = Colors.white;
  static Color colorGray = const Color(0xFF6C7077);
  static Color colorTextLocation = const Color(0xFF131312);
  static Color colorBlue = const Color(0xFF007AFF);
  static Color lineLayout = const Color(0xFFE5E5E5);
  static Color colorTextGray = const Color(0xFF686A71);
  static Color colorTitle = const Color(0xFFD29B00);
  static Color colorText = const Color(0xFFA49F9B);
  static Color colorBorderGray = const Color(0xFFF5F5F5);
  static Color colorContainerDark = const Color(0xFF1F1F1F);
  static Color colorLoadingDelivery = Colors.black.withOpacity(0.1);
  static Color colorInputContainer = const Color(0xFF1F1F1F);
  static Color colorAlertOrder = const Color(0xFFEDEDED);

  // Color background status
  static Color orderStatusRed = const Color(0xFFF20A39);
  static Color orderStatusGreen = const Color(0xFFE7FFE3);
  static Color orderStatusBlue = const Color(0xFF1791f5);
  static Color orderStatusBluePayment = const Color(0xFF053b64);
  static Color orderStatusGray = const Color(0xFF8B8888);
  static Color orderStatusYellow = const Color(0xFFFFD500);
  static Color orderStatusDarkBlue = const Color(0xFF083358);
  static Color orderStatusSeashell = const Color(0xFFFFF5EC);

  // Color text status
  static Color orderTextGreen = const Color(0xFF207513);
  static Color orderGreenLight = const Color(0xFF008D26);

  // Color Table
  static Color borderTable = const Color(0xFFE0E0E0);

  void switchMode({bool isDarkTheme = false}) {
    if (!isDarkTheme) {
      //white
      colorAppBarDark = Colors.white;
      colorContainerDark = Colors.white;
      colorBackground = const Color(0xFFEEEEEE);
      colorDarkGray = const Color(0xFFEEEEEE);
      colorItemDarkWhite = Colors.white;
      colorWhiteDark = Colors.black;
      colorDivider = const Color(0xFFF5F5F5);
      colorWhiteGrey = Colors.white;
      colorTextGray = const Color(0xFF686A71);
      colorLoadingDelivery = Colors.black.withOpacity(0.1);
      colorInputContainer = Colors.grey[300]!;
      colorAlertOrder = const Color(0xFFEDEDED);
      colorWhiteDarkHeader = Colors.black;
    } else {
      //dart
      colorAppBarDark = const Color(0xFF1F1F1F);
      colorContainerDark = const Color(0xFF1F1F1F);
      colorBackground = Colors.black;
      colorDarkGray = const Color(0xFFEEEEEE);
      colorItemDarkWhite = Colors.white;
      colorWhiteDark = Colors.white;
      colorDivider = Colors.black;
      colorWhiteGrey = Colors.grey;
      colorTextGray = const Color(0xFF686A71);
      colorLoadingDelivery = const Color(0xFF1F1F1F);
      colorInputContainer = const Color(0xFF1F1F1F);
      colorAlertOrder = Colors.black;
      colorWhiteDarkHeader = Colors.black;
    }
  }
}
