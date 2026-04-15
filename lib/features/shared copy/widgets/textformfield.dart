import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/core/classes/text_style.dart';
import 'package:mobile_app/core/functions/check_is_dark_mode.dart';
import 'package:mobile_app/features/shared%20copy/resources/app_colors.dart';
import 'package:mobile_app/features/shared%20copy/widgets/app_image.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final void Function()? onTap;
  final void Function()? suffixIconOnTap;
  //final ValueChanged<String> valueChanged;
  final IconData? icon;
  final IconData? suffixIcon;
  final bool? obscureText;
  final String image;
  final void Function()? onPressed;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool isName;
  final void Function(String)? onChanged;
  final TextStyle? hintStyle;
  final TextStyle? testFieldStyle;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool isBorder;
  final Widget? suffixIconWidget;
  final bool expands;
  final String? Function(String?)? validator;
  final bool isChat;
  final bool isReadOnly;
  final void Function(String)? onFieldSubmitted;
  final String obscuringCharacter;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.onTap,
    this.icon,
    this.obscureText,
    //required this.valueChanged,
    this.suffixIconOnTap,
    this.suffixIcon,
    this.image = "",
    this.onPressed,
    this.prefixIcon,
    this.keyboardType,
    this.isName = false,
    this.onChanged,
    this.hintStyle,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.isBorder = false,
    this.suffixIconWidget,
    this.expands = false,
    this.validator,
    this.isChat = false,
    this.isReadOnly = false,
    this.testFieldStyle,
    this.onFieldSubmitted,
    this.obscuringCharacter = '*',
    this.textInputAction,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 48.h,
      child: TextFormField(
        obscuringCharacter: obscuringCharacter,
        style: testFieldStyle,
        expands: expands,
        maxLength: maxLength,
        minLines: minLines,
        readOnly: isReadOnly,
        onTap: onTap,
        maxLines: obscureText == true
            ? 1
            : maxLines, // Force maxLines to 1 if obscureText is true
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return "please Enter This TextField";
              } else {
                return null;
              }
            },
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintStyle: hintStyle ??
              AppTextStyle.textStyle(
                appFontSize: 14.sp,
                appFontWeight: FontWeight.w400,
                color: ColorResources.hintIconGrey,
              ),
          suffixIcon: suffixIconWidget ??
              IconButton(
                onPressed: suffixIconOnTap,
                icon: Icon(suffixIcon, color: ColorResources.greyColor),
              ),
          hintText: hintText,
          labelText: labelText,
          prefixIcon: image.isNotEmpty || image != ""
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  child: AppImage(
                    assetPath: image,
                    height: 24.h,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                      isDark
                          ? ColorResources.black300
                          : ColorResources.black500,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : prefixIcon,
        ),
      ),
    );
  }
}
