import 'package:mobile_app/core/classes/price_rang.dart';

extension PriceRangeExtension on double {
  PriceRange negotiationRange({double percentage = 0.2}) {
    return PriceRange(basePrice: this, percentage: percentage);
  }
}
