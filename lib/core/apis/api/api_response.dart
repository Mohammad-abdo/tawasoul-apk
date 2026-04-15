class ApiResponse {
  final dynamic data;
  final int statusCode;
  final Map<String, dynamic>? headers;

  ApiResponse({
    required this.data,
    required this.statusCode,
    this.headers,
  });
}