import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/core/constants/app_colors.dart';

/// Loader موحّد: لون واحد في كل المشروع، وحجم ثابت للمنتصف.
class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.size,
    this.strokeWidth,
    this.color,
    this.isCentered = false,
  });

  /// لون موحد لجميع الـ loaders.
  static Color get _loaderColor => AppColors.primary;

  /// حجم الـ loader في المنتصف (شاشة كاملة).
  static double get _centeredSize => 40.r;
  /// سمك الخط للمنتصف — عريض شوية.
  static double get _centeredStrokeWidth => 4;

  /// حجم الدائرة. لو null: عادي 24.r، أو _centeredSize لو isCentered.
  final double? size;
  /// سمك الخط. الافتراضي 2.
  final double? strokeWidth;
  /// لون اختياري (مثلاً للـ banner عشان يظهر على الخلفية الداكنة).
  final Color? color;
  /// لو true يُلف في Center بحجم مناسب للمنتصف.
  final bool isCentered;

  /// Loader صغير داخل زر أو نص (لون موحد، حجم 20).
  static Widget get small => AppLoader(
        size: 20,
        strokeWidth: 2,
      );

  /// Loader في منتصف الشاشة بحجم ولون موحد.
  static Widget get centered => AppLoader(isCentered: true);

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? (isCentered ? _centeredSize : 24.r);
    final loader = SizedBox(
      width: effectiveSize,
      height: effectiveSize,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? (isCentered ? _centeredStrokeWidth : 2),
        valueColor: AlwaysStoppedAnimation<Color>(color ?? _loaderColor),
      ),
    );
    if (isCentered) {
      return Center(child: loader);
    }
    return loader;
  }
}
