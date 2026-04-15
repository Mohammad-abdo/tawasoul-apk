import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension TextThemeX on BuildContext {
  // Display
  TextStyle get displayL =>
      Theme.of(this).textTheme.displayLarge!.copyWith(fontSize: 57.sp);
  TextStyle get displayM =>
      Theme.of(this).textTheme.displayMedium!.copyWith(fontSize: 45.sp);
  TextStyle get displayS =>
      Theme.of(this).textTheme.displaySmall!.copyWith(fontSize: 36.sp);

  // Headlines
  TextStyle get h1 =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(fontSize: 32.sp);
  TextStyle get h2 =>
      Theme.of(this).textTheme.headlineMedium!.copyWith(fontSize: 28.sp);
  TextStyle get h3 =>
      Theme.of(this).textTheme.headlineSmall!.copyWith(fontSize: 24.sp);

  // Titles
  TextStyle get titleL =>
      Theme.of(this).textTheme.titleLarge!.copyWith(fontSize: 22.sp);
  TextStyle get titleM =>
      Theme.of(this).textTheme.titleMedium!.copyWith(fontSize: 16.sp);
  TextStyle get titleS =>
      Theme.of(this).textTheme.titleSmall!.copyWith(fontSize: 14.sp);

  // Body
  TextStyle get bodyL =>
      Theme.of(this).textTheme.bodyLarge!.copyWith(fontSize: 16.sp);
  TextStyle get bodyM =>
      Theme.of(this).textTheme.bodyMedium!.copyWith(fontSize: 14.sp);
  TextStyle get bodyS =>
      Theme.of(this).textTheme.bodySmall!.copyWith(fontSize: 12.sp);

  // Labels
  TextStyle get labelL =>
      Theme.of(this).textTheme.labelLarge!.copyWith(fontSize: 14.sp);
  TextStyle get labelM =>
      Theme.of(this).textTheme.labelMedium!.copyWith(fontSize: 12.sp);
  TextStyle get labelS =>
      Theme.of(this).textTheme.labelSmall!.copyWith(fontSize: 11.sp);
}
