import 'package:flutter/material.dart';
import 'package:mobile_app/core/extensions/theme.dart';

class TitleHeader extends StatelessWidget {
  const TitleHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.titleM.copyWith(
        
      ),
      // style: AppTextStyle.textStyle(
      //   appFontSize: 16.sp,
      //   appFontWeight: FontWeight.w400,
      //   color: ColorResources.blackColorApp,
      //   appFontHeight: 1.2,
      //   letterSpacing: 0,
      // ),
    );
  }
}
