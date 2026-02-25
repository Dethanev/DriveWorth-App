import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppConfig {
  static const double neuBorderWidth = 2;
  static const Color neuBorderColor = AppColors.black;
  static const double neuShadowOffset = 6;
  static const double neuShadowBlur = 0;

  static BoxDecoration neuStyle({
    required Color color,
    Border? border,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      border:
          border ?? Border.all(color: neuBorderColor, width: neuBorderWidth),
      boxShadow:
          boxShadow ??
          [
            BoxShadow(
              color: AppColors.black,
              offset: const Offset(neuShadowOffset, neuShadowOffset),
              blurRadius: neuShadowBlur,
            ),
          ],
    );
  }
}
