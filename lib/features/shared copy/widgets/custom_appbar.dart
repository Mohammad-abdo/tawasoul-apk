import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/core/classes/text_style.dart';
import 'package:mobile_app/core/constants/app_colors.dart';
import 'package:mobile_app/core/extensions/navigations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = "",
    this.isActionIcon = true,
    this.isNotification = false,
    this.isBack = true,
    this.isSliver = false,
    this.isPageInNav = false,
    this.backgroundColor,
    this.elevation = 0,
    this.scrolledUnderElevation = 0,
    this.titleColor,
    this.titleFontWeight = FontWeight.w400,
    this.leadingIconColor,
    this.leadingIconSize,
    /// يستبدل زر الرجوع (مثلاً زر القائمة في الـ drawer).
    this.leading,
  });

  final String title;
  final bool isActionIcon;
  final bool isNotification;
  final bool isBack;
  final bool isSliver;
  final bool isPageInNav;

  /// إن وُجد يُطبَّق على الـ AppBar (مثلاً أبيض للشاشات الداخلية).
  final Color? backgroundColor;
  final double elevation;
  final double scrolledUnderElevation;

  /// لون العنوان؛ الافتراضي [AppColors.primaryColor] إن كان null.
  final Color? titleColor;
  final FontWeight titleFontWeight;

  /// لون وحجم أيقونة الرجوع؛ الافتراضي لون الـ primary إن كان [leadingIconColor] null.
  final Color? leadingIconColor;
  final double? leadingIconSize;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      centerTitle: true,
      title: Text(
        title,
        style: AppTextStyle.textStyle(
          appFontSize: 18.sp,
          appFontWeight: titleFontWeight,
          color: titleColor ?? AppColors.primary,
        ),
      ),
      leading: leading ??
          (isBack
              ? _BackIconButton(
                  onPressed: () => context.canPop(),
                  color: leadingIconColor,
                  size: leadingIconSize,
                )
              : null),
      actions: [
        if (isActionIcon == true)
          GestureDetector(
            onTap: () {
              context.pushNamedAndRemoveUntil('home');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 26),
              child: Container(),
            ),
          ),
        //if (isNotification == true) NotificationIcon(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

/// أيقونة الرجوع الموحّدة: [Icons.arrow_back] يعكس الاتجاه تلقائياً مع RTL (لا يعتمد على `isArabic`).
class BackIconButton extends StatelessWidget {
  const BackIconButton({
    super.key,
    required this.onPressed,
    this.size,
    this.color,
    /// داخل أزرار دائرية صغيرة (مثل الخريطة) بدون حد أدنى 48px للمسة.
    this.shrinkWrap = false,
  });

  final VoidCallback onPressed;
  final double? size;
  final Color? color;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final useSize = size ?? 24.0;
    final useColor = color ?? AppColors.primary;
    final icon = Icon(Icons.arrow_back, size: useSize, color: useColor);

    if (shrinkWrap) {
      return GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: icon,
        ),
      );
    }

    return IconButton(
      onPressed: onPressed,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      icon: icon,
    );
  }
}

class _BackIconButton extends StatelessWidget {
  const _BackIconButton({
    required this.onPressed,
    this.color,
    this.size,
  });

  final VoidCallback onPressed;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return BackIconButton(
      onPressed: onPressed,
      color: color,
      size: size,
    );
  }
}
