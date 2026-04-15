import 'package:flutter/material.dart';

class AppColors {
  // light
  static const Color primaryColor = Color(0xFF1B1E23);
  static const Color orangColor = Color(0xFFFFA500);
  static const Color greyColor = Color(0xFF808080); //#808080
  static const Color borderTextForm = Color(0xFFE6E5E5); //#808080
  static const Color hintColor = Color(0xff596273); //#434343

  static const Color backgroundLight = Color(0xFFF9F9F9);
  static const Color textPrimaryLight = Color(0xFF1A1A1A);
  static const Color primaryColor800 = Color(0xFF102E56);
  static const Color greenColor = Color(0xFF0F9D58); //0xffFF3B30
  static const Color colorsGreen = Color(0xFF0F9D58);
  static const Color blackColor = Color(0xff000000);
  static const Color black600 = Color(0xff5D686F);
  static const Color black700 = Color(0xff909BA2);
  static const Color black700Last53 = Color(0xff464E53);
  static const Color black500 = Color(0xff1A1D1F);
  static const Color black500Last21 = Color(0xff212121);
  static const Color black400 = Color(0xff99A1AF);
  static const Color black50 = Color(0xffF1F2F3);
  static const Color black300 = Color(0xffACB4B9);
  static const Color black100 = Color(0xffE3E6E8);
  static const Color blackColorApp = Color(0xff1A1A1A);
  static const Color whiteColorApp = Color(0xffF3F9EC);
  static const Color whiteColor = Color(0xffffffff);
  static const Color greyDark = Color(0xff414141); //0xff212121
  static const Color greyColor66 = Color(0xFF666666);
  static const Color greyColor80 = Color(0xFF6B7280); //0xff6B7280
  static const Color csk = Color(0xFF03002A); //0xffF1F2F3
  static const Color colorRedApp = Color(0xFFFF3B30); //0xff4D4D4D
  static const Color colorDeposit = Color(0xFFE7000B); //0xff1A1D1F
  static const Color colorWithdraw = Color(0xFF34C759);
  static const Color primary100 = Color(0xFFD4E3F7);
  static const Color primary500 = Color(0xff1A4D8F);
  static const Color primary50 = Color(0xffE9F1FB); //0xff909BA2

  // Light Mode extras
  static const Color surfaceLight = Color(0xFFFFFFFF); // سطح أبيض للكروت
  static const Color categoryCardBackground = Color(
    0xFFE2EFF2,
  ); // خلفية كروت التصنيفات

  // ألوان فئات الخدمات (Services categories)
  static const Color categoryColorCyan = Color(0xFFE2F8FF);
  static const Color categoryColorPink = Color(0xFFFFE2F9);
  static const Color categoryColorBlue = Color(0xFFE2EBFF);
  static const Color categoryColorMagenta = Color(0xFFFFE2F8);
  static const Color categoryColorGreen = Color(0xFFE2FFEA);
  static const Color categoryColorPeach = Color(0xFFFFEEE2);

  // ألوان فئات Used Items (إضافة اللون البنفسجي فقط - الباقي مكرر)
  static const Color categoryColorLavender = Color(0xFFF0E4FF);
  static const Color categoryColorLavenderBorder = Color(0xFF7100FF);

  // حدود فئات Activities و Jobs عند التحديد
  static const Color categoryColorPinkBorder = Color(0xFFFF00CA);
  static const Color categoryColorMagentaBorder = Color(0xFFFF26CB);

  // ألوان فئات Jobs (اللون الفاتح الأحمر فقط - الباقي مكرر)
  static const Color categoryColorCoral = Color(0xFFFFE2E2);

  static const Color secondaryLight = Color(
    0xFF5C6BC0,
  ); // نسخة أفتح شويه من primaryLight
  static const Color inputBackgroundLight = Color(0xFFF1F2F3); // خلفية Inputs
  static const Color textSecondaryLight = Color(0xFF6B7280); // نصوص ثانوية

  // Dark
  static const Color primaryDark = Color(0xFF7986CB);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color textPrimaryDark = Color(0xFFEDEDED);
  // Dark Mode extras
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color secondaryDark = Color(
    0xFF7986CB,
  ); // نسخة أفتح شويه من primaryDark
  static const Color inputBackgroundDark = Color(0xFF1C1C1C);
  static const Color textSecondaryDark = Color(0xFFB0B0B0); // نصوص ثانوية

  // ألوان من الشاشات (كانت مكتوبة مباشرة في الويدجتس)
  static const Color capsulePink = Color(0xFFFCE4EC); // كبسولة المسار (route) في الهوم
  static const Color paymentCardBg = Color(0x1AFFFFFF); // خلفية كارد الفيزا (أبيض 10%)
  static const Color paymentCardShadow = Color(0x1A03002A); // ظل كارد الفيزا (#03002A 10%)
  static const Color cancelRed = Color(0xFFC80000); // زر إلغاء / Decline
  static const Color buttonGradientGrey = Color(0xFF595959); // بداية جرادينت Add Your Price
  static const Color overlayPink = Color(0xFFB33185); // أورفيلي على الخريطة
  static const Color drawerDarkBg = Color(0xFF2D2D2D); // خلفية الدروير
  static const Color drawerIconBg = Color(0xFF3A3A3A); // خلفية أيقونات الدروير
  static const Color transactionRed = Color(0xFFE64D48); // معاملات خصم
  static const Color transactionGreen = Color(0xFF41C460); // معاملات إيداع
  static const Color walletGradientGreen = Color(0xFF699933); // جرادينت المحفظة
  static const Color walletGradientDark = Color(0xFF1F2A13); // جرادينت المحفظة (داكن)
  static const Color displayInfoBg = Color(0xFFF4F6F9); // خلفية عرض المعلومات
  static const Color displayInfoOverlay = Color(0xFF111C30); // أورفيلي
  static const Color otpFieldBg = Color(0xFFFFF8E1); // خلفية حقل OTP
  static const Color otpFieldBorder = Color(0xFFE8E0D0); // حدود حقل OTP
  static const Color splashOrange = Color(0xFFF98600); // لون شاشة السبلاش
  static const Color filterBarDark = Color(0xFF212937); // خلفية شريط الفلتر
  static const Color filterBarBorder = Color(0xFF394760); // حدود الفلتر
  static const Color filterItemBg = Color(0xFF263040); // خلفية عنصر الفلتر
  static const Color filterItemBorder = Color(0xFF4D5F80); // حدود عنصر الفلتر
  static const Color filterChipBg = Color(0xFFEFF1F5); // خلفية شيب الفلتر
  static const Color filterApplyGreen = Color(0xFF22C55E); // زر تطبيق الفلتر
  static const Color filterApplyGreenDark = Color(0xFF16A34A);
  static const Color filterDropdownBg = Color(0xFF2F3B50); // خلفية القائمة المنسدلة
  static const Color hintIconGrey = Color(0xFF999999); // لون أيقونة التلميح
  static const Color languageDarkText = Color(0xFF110808); // نص داكن في شاشة اللغة
}

// Backward compatibility for existing code that still uses `ColorResources`.
typedef ColorResources = AppColors;
