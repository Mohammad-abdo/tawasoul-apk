import 'package:mobile_app/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<bool> call({
    required String phone,
    required String otp,
  }) {
    return repository.verifyOtp(phone: phone, otp: otp);
  }
}
