import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/core/classes/text_style.dart';
import 'package:mobile_app/core/constants/app_colors.dart';
import 'package:mobile_app/main.dart';

enum SnackBarType { success, error, warning, info }

class AppSnackBar {
  static void show(String message, {SnackBarType type = SnackBarType.info}) {
    final color = _getColor(type);

    ScaffoldMessenger.of(navigatorKey.currentContext!)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          margin: EdgeInsets.all(16.w),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyle.textStyle(
              appFontSize: 16.sp,
              color: AppColors.white,
              appFontWeight: FontWeight.w400,
            ),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
  }

  static Color _getColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return AppColors.success;
      case SnackBarType.error:
        return AppColors.error;
      case SnackBarType.warning:
        return AppColors.warning;
      case SnackBarType.info:
        return AppColors.info;
    }
  }
}
