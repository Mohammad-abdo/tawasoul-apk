class ResponseAuth {
  ResponseAuth({
    required this.success,
    required this.data,
  });

  final bool? success;
  final AuthData? data;

  factory ResponseAuth.fromJson(Map<String, dynamic> json) {
    return ResponseAuth(
      success: json["success"],
      data: json["data"] == null ? null : AuthData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };

  @override
  String toString() {
    return "$success, $data, ";
  }
}

class AuthData {
  AuthData({
    required this.user,
    required this.token,
  });

  final User? user;
  final String? token;

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };

  @override
  String toString() {
    return "$user, $token, ";
  }
}

class User {
  User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.relationType,
    required this.language,
    required this.allowPrivateMsg,
    required this.isAnonymous,
    required this.avatar,
    required this.isActive,
    required this.isApproved,
    required this.isPhoneVerified,
    required this.createdAt,
  });

  final String? id;
  final String? username;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? relationType;
  final String? language;
  final bool? allowPrivateMsg;
  final bool? isAnonymous;
  final String? avatar;
  final bool? isActive;
  final bool? isApproved;
  final bool? isPhoneVerified;
  final DateTime? createdAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      fullName: json["fullName"],
      email: json["email"],
      phone: json["phone"],
      relationType: json["relationType"],
      language: json["language"],
      allowPrivateMsg: json["allowPrivateMsg"],
      isAnonymous: json["isAnonymous"],
      avatar: json["avatar"],
      isActive: json["isActive"],
      isApproved: json["isApproved"],
      isPhoneVerified: json["isPhoneVerified"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "relationType": relationType,
        "language": language,
        "allowPrivateMsg": allowPrivateMsg,
        "isAnonymous": isAnonymous,
        "avatar": avatar,
        "isActive": isActive,
        "isApproved": isApproved,
        "isPhoneVerified": isPhoneVerified,
        "createdAt": createdAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $username, $fullName, $email, $phone, $relationType, $language, $allowPrivateMsg, $isAnonymous, $avatar, $isActive, $isApproved, $isPhoneVerified, $createdAt, ";
  }
}
