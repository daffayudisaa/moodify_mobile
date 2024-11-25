import 'package:flutter/material.dart';

class ScreenUtils {
  static double getMultiplier(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 1.0;
    } else if (screenWidth < 1200) {
      return 1.2;
    } else {
      return 1.4;
    }
  }

  static double getFontSize(BuildContext context, double baseFontSize) {
    double multiplier = getMultiplier(context);
    return baseFontSize * multiplier;
  }

  static double getImageSize(BuildContext context, double baseImageSize) {
    double multiplier = getMultiplier(context);
    return baseImageSize * multiplier;
  }

  static double getVerticalPadding(BuildContext context, double basePadding) {
    double multiplier = getMultiplier(context);
    return basePadding * multiplier;
  }
}
