import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/features/shared%20copy/resources/app_colors.dart';
import 'package:mobile_app/features/shared%20copy/widgets/app_image.dart';

class CustomSmallContainer extends StatelessWidget {
  const CustomSmallContainer({
    super.key,
    required this.icon,
    required this.color,
    this.onTap,
    this.colorContainer,
    this.height,
    this.width,
    this.isBorder = false,
  });
  final String icon;
  final Color color;
  final Color? colorContainer;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final bool isBorder;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        alignment: Alignment.center,
        height: height, //?? 40.h,
        width: width, //?? 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: colorContainer ?? ColorResources.categoryColorCoral,
        ),
        child: AppImage(
          assetPath: icon,
          width: 20.w,
          height: 20.h,
          // colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }
}
