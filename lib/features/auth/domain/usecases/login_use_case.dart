import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/apis/error/failure.dart';
import 'package:mobile_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:mobile_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthUserEntityData>> call({
    required String username,
    required String password,
  })async{
    return await repository.login(username: username, password: password);
  }

}
