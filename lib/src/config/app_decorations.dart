import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDecorations {
  static const double neuBorderWidth = 3;
  static const Offset neuShadowOffset = Offset(4, 4);
  static const double neuShadowBlur = 0;

  static BoxDecoration get neuCard => BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.black, width: neuBorderWidth),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black,
            offset: neuShadowOffset,
            blurRadius: neuShadowBlur,
          ),
        ],
      );

  static BoxDecoration neuButton({Color? backgroundColor}) => BoxDecoration(
        color: backgroundColor ?? AppColors.secondary,
        border: Border.all(color: AppColors.black, width: neuBorderWidth),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black,
            offset: neuShadowOffset,
            blurRadius: neuShadowBlur,
          ),
        ],
      );
}
