import 'package:mobile_app/core/apis/links/api_keys.dart';

class ErrorModel {
  ErrorModel({required this.message, required this.code});
  final String? code;
  final String? message;

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      code: json[ApiKeys.code],
      message: json[ApiKeys.message],
    );
  }

  Map<String, dynamic> toJson() => {
        ApiKeys.code: code,
        ApiKeys.message: message,
      };

  @override
  String toString() {
    return "$code , $message, ";
  }
}
