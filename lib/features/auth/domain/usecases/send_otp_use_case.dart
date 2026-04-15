import 'package:mobile_app/features/auth/domain/repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<bool> call({
    required String fullName,
    required String phone,
    required String relationType,
    required bool agreedToTerms,
  }) {
    return repository.sendOtp(
      fullName: fullName,
      phone: phone,
      relationType: relationType,
      agreedToTerms: agreedToTerms,
    );
  }
}
