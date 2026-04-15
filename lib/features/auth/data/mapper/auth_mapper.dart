import 'package:mobile_app/features/auth/data/models/response_auth.dart';
import 'package:mobile_app/features/auth/domain/entities/auth_user_entity.dart';

extension AuthMapper on AuthData {
  AuthUserEntityData toEntity() => AuthUserEntityData(
        user: user?.toEntity(),
        token: token,
      );
}

extension AuthUserEntityMapper on User {
  AuthUserEntity toEntity() => AuthUserEntity(
        id: id,
        username: username,
        fullName: fullName,
        email: email,
        phone: phone,
        relationType: relationType,
        language: language,
        allowPrivateMsg: allowPrivateMsg,
        isAnonymous: isAnonymous,
        avatar: avatar,
        isActive: isActive,
        isApproved: isApproved,
        isPhoneVerified: isPhoneVerified,
        createdAt: createdAt,
      );
}
