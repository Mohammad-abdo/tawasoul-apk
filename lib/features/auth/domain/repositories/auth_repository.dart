import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/apis/error/failure.dart';
import 'package:mobile_app/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<bool> sendOtp({
    required String fullName,
    required String phone,
    required String relationType,
    required bool agreedToTerms,
  });

  Future<bool> verifyOtp({
    required String phone,
    required String otp,
  });

  Future<bool> resendOtp(String phone);

  Future<Either<Failure, AuthUserEntityData>> login({
    required String username,
    required String password,
  });

  Future<void> logout();

  Future<AuthUserEntity?> getCurrentUser();

  Future<bool> updateProfile({
    String? fullName,
    String? email,
  });

  bool isLoggedIn();
}
