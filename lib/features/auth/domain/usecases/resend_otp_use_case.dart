import 'package:mobile_app/features/auth/domain/repositories/auth_repository.dart';

class ResendOtpUseCase {
  final AuthRepository repository;

  ResendOtpUseCase(this.repository);

  Future<bool> call(String phone) {
    return repository.resendOtp(phone);
  }
}
