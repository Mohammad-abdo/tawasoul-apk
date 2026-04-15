import 'package:mobile_app/features/auth/domain/repositories/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<bool> call({
    String? fullName,
    String? email,
  }) {
    return repository.updateProfile(fullName: fullName, email: email);
  }
}
