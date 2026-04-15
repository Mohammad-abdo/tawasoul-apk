import 'package:dio/dio.dart';
import 'package:mobile_app/core/apis/api/api_interceptor.dart';
import 'package:mobile_app/core/apis/api/api_response.dart';
import 'package:mobile_app/core/apis/api/api_services.dart';
import 'package:mobile_app/core/apis/error/server_exception.dart';
import 'package:mobile_app/core/apis/links/end_points.dart';
import 'package:mobile_app/core/constants/app_strings.dart';

class DioServices extends ApiServices {
  final Dio dio;

  DioServices({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      headers: {Headers.acceptHeader: AppStrings.jsonContentType},
    );

    dio.interceptors.add(ApiInterceptor());

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ),
    );
  }

  // ===============================
  // 🔥 Helper To Reduce Repetition
  // ===============================

  ApiResponse _handleResponse(Response response) {
    return ApiResponse(
      data: response.data,
      statusCode: response.statusCode ?? 0,
      headers: response.headers.map,
    );
  }

  Options _buildOptions({Map<String, String>? headers, bool isJson = false}) {
    return Options(
      headers: headers,
      contentType: isJson ? AppStrings.jsonContentType : null,
    );
  }

  dynamic _handleData(dynamic data, bool isForm) {
    if (isForm && data != null) {
      return FormData.fromMap(data);
    }
    return data;
  }

  // ===============================
  // ✅ GET
  // ===============================

  @override
  Future<ApiResponse> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(headers: headers),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  // ===============================
  // ✅ POST
  // ===============================

  @override
  Future<ApiResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
    bool isJson = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: _handleData(data, isForm),
        queryParameters: queryParameters,
        options: _buildOptions(headers: headers, isJson: isJson),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  // ===============================
  // ✅ PUT
  // ===============================

  @override
  Future<ApiResponse> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: _handleData(data, isForm),
        queryParameters: queryParameters,
        options: _buildOptions(headers: headers),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  // ===============================
  // ✅ PATCH
  // ===============================

  @override
  Future<ApiResponse> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: _handleData(data, isForm),
        queryParameters: queryParameters,
        options: _buildOptions(headers: headers),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  // ===============================
  // ✅ DELETE
  // ===============================

  @override
  Future<ApiResponse> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: _handleData(data, isForm),
        queryParameters: queryParameters,
        options: _buildOptions(headers: headers),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }
}
