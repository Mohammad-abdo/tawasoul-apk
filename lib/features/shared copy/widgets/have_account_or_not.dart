import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/core/classes/text_style.dart';
import 'package:mobile_app/features/shared%20copy/resources/app_colors.dart';

class HaveAccountOrNot extends StatelessWidget {
  const HaveAccountOrNot({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    this.onTap,
  });
  final String firstTitle;
  final String secondTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: firstTitle,
            style: AppTextStyle.textStyle(
              appFontSize: 16.sp,
              appFontWeight: FontWeight.w400,
              appFontHeight: 21.sp,
              color: ColorResources.primaryColor,
            ),
          ),
          TextSpan(
            text: " ",
            style: AppTextStyle.textStyle(
              appFontSize: 16.sp,
              appFontWeight: FontWeight.w400,
              appFontHeight: 21.sp,
              color: ColorResources.primaryColor,
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: secondTitle,
            style: AppTextStyle.textStyle(
              appFontSize: 16.sp,
              appFontHeight: 21.sp,
              appFontWeight: FontWeight.w700,
              color: ColorResources.orangColor,
            ),
          ),
        ],
      ),
    );
  }
}
