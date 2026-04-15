class PriceRange {
  final double basePrice;
  final double percentage;

  const PriceRange({required this.basePrice, this.percentage = 0.2});

  /// أقل سعر مسموح
  double get min => basePrice * (1 - percentage);

  /// أعلى سعر مسموح
  double get max => basePrice * (1 + percentage);

  /// التحقق هل السعر داخل الرينج
  bool contains(double value) {
    return value >= min && value <= max;
  }

  /// تصحيح السعر لو خارج الرينج (Clamp)
  double clamp(double value) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// تحويل السعر لنص عرض
  String get displayText {
    return "تقدر تفاوض بين ${min.toStringAsFixed(0)} و ${max.toStringAsFixed(0)}";
  }

  /// نسبة السعر بالنسبة للـ base
  double progress(double value) {
    if (value <= min) return 0;
    if (value >= max) return 1;

    return (value - min) / (max - min);
  }
}
