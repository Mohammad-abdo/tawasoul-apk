
import 'package:mobile_app/core/apis/links/end_points.dart';

extension ImageUrlExtension on String? {
  String toImageUrl() {
    if (this == null || this!.trim().isEmpty) {
      return '';
    }

    final cleaned = _normalizeProtocol(this!.trim());
    final uri = Uri.parse(cleaned);

    // لو URL كامل already
    if (uri.hasScheme && uri.host.isNotEmpty) {
      return uri.toString();
    }

    // لو Path بس → نضيف baseUrl
    return Uri.parse(EndPoints.baseUrl).resolve(cleaned).toString();
  }

  String _normalizeProtocol(String url) {
    return url.replaceAll(RegExp(r'^(https?:\/\/)+'), 'https://');
  }
}
