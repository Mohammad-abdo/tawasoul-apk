// class Failure {
//   Failure({ this.success,  this.message});

//   final bool? success;
//   final String? message;

//   factory Failure.fromJson(Map<String, dynamic> json) {
//     return Failure(success: json["success"], message: json["message"]);
//   }

//   Map<String, dynamic> toJson() => {"success": success, "message": message};

//   @override
//   String toString() {
//     return "$success, $message, ";
//   }
// }

class Failure {
  Failure({
     this.success,
     this.error,
  });

  final bool? success;
  final Error? error;

  factory Failure.fromJson(Map<String, dynamic> json) {
    return Failure(
      success: json["success"],
      error: json["error"] == null ? null : Error.fromJson(json["error"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error?.toJson(),
      };

  @override
  String toString() {
    return "$success, $error, ";
  }
}

class Error {
  Error({
     this.code,
     this.message,
  });

  final String? code;
  final String? message;

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      code: json["code"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };

  @override
  String toString() {
    return "$code, $message, ";
  }
}
