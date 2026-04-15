import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/core/classes/text_style.dart';
import 'package:mobile_app/features/shared%20copy/resources/app_colors.dart';
import 'package:mobile_app/features/shared%20copy/widgets/app_image.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.title = '',
    this.onPressed,
    this.style,
    this.isIcon,
    this.icon = '',
    this.color,
    this.widget,
    this.height,
    this.padding,
    this.colorText,
     this.isLoading=false,
  });

  final String title;
  final void Function()? onPressed;
  final TextStyle? style;
  final bool? isIcon;
  final String icon;
  final Color? color;
  final Color? colorText;
  final Widget? widget;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    return GestureDetector(
        onTap: isLoading ? null : onPressed,
      child: Opacity(
        opacity: isDisabled ? 0.6 : 1.0,
        child: Container(
          height: height,
          alignment: Alignment.center,
          width: double.infinity,
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: color ?? ColorResources.primaryColor,
            border: color != null
                ? Border.all(color: ColorResources.primaryColor)
                : null,
            borderRadius: BorderRadius.circular(16.r),
            // gradient: color != null
            //     ? null
            //     : LinearGradient(colors: [Color(0xff2F9D8C), Color(0xff42A150)]),
          ),
          child: isIcon != null && isIcon == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20.w,
                  children: [
                    AppImage(
                      assetPath: icon,
                      height: 16.h,
                      width: 16.w,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      title,
                      style:
                          style ??
                          AppTextStyle.textStyle(
                            appFontSize: 16.sp,
                            appFontWeight: FontWeight.w700,
                            color:
                                colorText ?? color ?? ColorResources.whiteColor,
                          ),
                    ),
                  ],
                )
              : widget ??
                    Text(
                      title,
                      style: AppTextStyle.textStyle(
                        appFontSize: 16.sp,
                        appFontWeight: FontWeight.w700,
                        color: colorText ?? color ?? ColorResources.whiteColor,
                      ),
                    ),
        ),
      ),
    );
  }
}
