import 'package:dio/dio.dart';
import 'package:mobile_app/core/apis/links/api_keys.dart';
import 'package:mobile_app/core/storage/secure_storage_service.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Prefer accessToken (real token after login/submitOtp), fallback to token (temporary for register/sendOtp)
    String? token = await SecureStorageService.instance.getValue(
      key: ApiKeys.accessToken,
    );
    if (token == null || token.isEmpty) {
      token = await SecureStorageService.instance.getValue(
        key: ApiKeys.token,
      );
    }

    // لا تفرض JSON على multipart — Dio يضبط boundary لـ FormData
    if (options.data is! FormData) {
      options.headers["Content-Type"] = "application/json";
    }
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    super.onRequest(options, handler);
  }
}
