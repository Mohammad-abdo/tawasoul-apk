import 'package:mobile_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:mobile_app/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<AuthUserEntity?> call() {
    return repository.getCurrentUser();
  }
}
