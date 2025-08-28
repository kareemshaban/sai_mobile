import 'package:flutter/material.dart';

class ColorManager {
  static const Color white = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF2B7BFF);
  static const Color red = Colors.red;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color scaffoldBackground = Color(0xFFF8F8F8);
  static const Color textGrey = Color(0xFF565656);
  static const Color textGrey2 = Color(0xFF808080);
  static const Color dividerColor = Color(0xFF707070);
  static const Color borderColor = Color(0xFFBCBCBC);
  static const Color lightGreyColor = Color(0xFFD9D9D9);
  static const Color iconGreyColor = Color(0xFF636363);
  static const Color iconGreyColor2 = Color(0xFFA6A6A6);
  static const Color green = Color(0xFF00BD61);
  static const Color yellowColor = Color(0xFFEEFF00);
  static const Color textShadow = Color(0x4072C1B8);
  static const Color lightWhiteColor = Color(0xFFA3A3A3);
  static const Color textGrey3 = Color(0xFF495057);
  static const Color textGrey4 = Color(0xFF798590);
  static const Color topSenderColor = Color(0xFFFF6378);
  static const Color topRoomsColor = Color(0xFFFFB922);
  static const Color topBillionaireColor = Color(0xFF55B1FD);
  static const Color rippleColor = Color(0xFF78C4F1);
  static const Color darkGreyColor = Color(0xFF222433);
  static const Color yellowColor2 = Color(0xFFFFDEAF);
  static const Color yellowColor3 = Color(0xFFFDE6CC);
  static const Color appRedColor = Color(0xFFFF1E1E);
  static const Color storyBorderColor = Color(0xFF4B9FFF);
  static const Color onlineColor = Color(0xFF00FF26);
  static const Color newNotificationColor = Color(0xFFB09CFF);
  static const Color likeColor = Color(0xFFFF0099);
  static const Color messageColor = Color(0xFFEBEBEB);
  static const Color topRoomsColor2 = Color(0xFF60BEFE);
  static const Color topSenderColor2 = Color(0xFFFFBC06);
  static const Color topBillionaireColor2 = Color(0xFFFD757A);
  static const Color privacyColor = Color(0xFFE8E8E8);

  static LinearGradient gradientScaffoldColor = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0, 0.3],
    colors: <Color>[
      Color(0xff75CEEB),
      Color(0xff2F5291),
    ],
    tileMode: TileMode.mirror,
  );
  static LinearGradient walletGradientColor = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xff6CA3FF),
      Color(0xff2B7AFF),
    ],
  );
  static LinearGradient coverImageColor = LinearGradient(
    colors: [
      ColorManager.black.withOpacity(.3),
      ColorManager.white,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
