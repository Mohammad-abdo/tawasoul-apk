import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_app/core/apis/api/api_response.dart';
import 'package:mobile_app/core/apis/api/api_services.dart';
import 'package:mobile_app/core/apis/error/failure.dart';
import 'package:mobile_app/core/apis/error/server_exception.dart';
import 'package:mobile_app/core/apis/links/end_points.dart';
import 'package:mobile_app/core/constants/app_strings.dart';

class HttpServices extends ApiServices {
  final http.Client client;

  HttpServices({required this.client});

  // ===============================
  // 🔥 Helpers
  // ===============================

  Uri _buildUri(String path, Map<String, dynamic>? queryParameters) {
    final uri = Uri.parse("${EndPoints.baseUrl}$path");

    if (queryParameters == null) return uri;

    return uri.replace(
      queryParameters: queryParameters.map((k, v) => MapEntry(k, v.toString())),
    );
  }

  Map<String, String> _buildHeaders({
    Map<String, String>? headers,
    bool isJson = false,
  }) {
    return {
      if (isJson) HttpHeaders.contentTypeHeader: AppStrings.jsonContentType,
      ...?headers,
    };
  }

  dynamic _handleBody(dynamic data, bool isJson) {
    if (data == null) return null;
    return isJson ? jsonEncode(data) : data;
  }

  ApiResponse _handleSuccess(http.Response response) {
    final decoded = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    return ApiResponse(
      data: decoded,
      statusCode: response.statusCode,
      headers: response.headers,
    );
  }

  void _handleStatusCode(http.Response response) {
    if (response.statusCode >= 400) {
      _handleHttpError(response);
    }
  }

  Never _handleException(Object e) {
    if (e is SocketException) {
      throw ServerException(
        failure: Failure(error: Error(message: "No Internet Connection")),
      );
    } else if (e is TimeoutException) {
      throw ServerException(
          failure: Failure(error: Error(message: "Request Timeout")));
    } else {
      throw ServerException(
        failure:
            Failure(error: Error(message: "Unexpected Error: ${e.toString()}")),
      );
    }
  }

  Never _handleHttpError(http.Response response) {
    try {
      final errorModel = response.body.isNotEmpty
          ? Failure.fromJson(jsonDecode(response.body))
          : Failure(error:Error(message: "Unknown Server Error") );

      throw ServerException(failure: errorModel);
    } catch (_) {
      throw ServerException(
        failure: Failure(error: Error(message: "Unexpected Server Error")),
      );
    }
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
      final response = await client
          .get(
            _buildUri(path, queryParameters),
            headers: _buildHeaders(headers: headers),
          )
          .timeout(const Duration(seconds: 30));

      _handleStatusCode(response);

      return _handleSuccess(response);
    } catch (e) {
      _handleException(e);
    }
  }

  // ===============================
  // ✅ POST
  // ===============================

  @override
  Future<ApiResponse> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
    bool isJson = false,
  }) async {
    try {
      final response = await client
          .post(
            _buildUri(path, queryParameters),
            headers: _buildHeaders(headers: headers, isJson: isJson),
            body: _handleBody(data, isJson),
          )
          .timeout(const Duration(seconds: 30));

      _handleStatusCode(response);

      return _handleSuccess(response);
    } catch (e) {
      _handleException(e);
    }
  }

  // ===============================
  // ✅ PUT
  // ===============================

  @override
  Future<ApiResponse> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await client
          .put(
            _buildUri(path, queryParameters),
            headers: _buildHeaders(headers: headers, isJson: true),
            body: _handleBody(data, true),
          )
          .timeout(const Duration(seconds: 30));

      _handleStatusCode(response);

      return _handleSuccess(response);
    } catch (e) {
      _handleException(e);
    }
  }

  // ===============================
  // ✅ PATCH
  // ===============================

  @override
  Future<ApiResponse> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await client
          .patch(
            _buildUri(path, queryParameters),
            headers: _buildHeaders(headers: headers, isJson: true),
            body: _handleBody(data, true),
          )
          .timeout(const Duration(seconds: 30));

      _handleStatusCode(response);

      return _handleSuccess(response);
    } catch (e) {
      _handleException(e);
    }
  }

  // ===============================
  // ✅ DELETE
  // ===============================

  @override
  Future<ApiResponse> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await client
          .delete(
            _buildUri(path, queryParameters),
            headers: _buildHeaders(headers: headers, isJson: true),
            body: _handleBody(data, true),
          )
          .timeout(const Duration(seconds: 30));

      _handleStatusCode(response);

      return _handleSuccess(response);
    } catch (e) {
      _handleException(e);
    }
  }
}
