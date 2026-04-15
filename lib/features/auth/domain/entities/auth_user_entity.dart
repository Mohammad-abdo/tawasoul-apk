class AuthUserEntityData {
  final AuthUserEntity? user;
  final String? token;

  const AuthUserEntityData({
    required this.user,
    required this.token,
  });
}


class AuthUserEntity{
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

  AuthUserEntity({
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
}