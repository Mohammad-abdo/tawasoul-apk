import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/apis/error/failure.dart';
import 'package:mobile_app/core/apis/error/server_exception.dart';
import 'package:mobile_app/core/apis/links/api_keys.dart';
import 'package:mobile_app/core/apis/links/end_points.dart';
import 'package:mobile_app/core/classes/my_logger.dart';
import 'package:mobile_app/core/services/api_service.dart';
import 'package:mobile_app/core/storage/secure_storage_service.dart';
import 'package:mobile_app/features/auth/data/models/response_auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, ResponseAuth>> login(
      {required String userName, required String password});
  Future<Either<Failure, ResponseAuth>> register(
      {required String userName,
      required String password,
      required String email,
      required String phone});
}

class AuthRepositoryImp extends AuthRepository {
  final ApiService _apiService;

  AuthRepositoryImp({required  apiService})
      : _apiService = apiService;
  @override
  Future<Either<Failure, ResponseAuth>> login(
      {required String userName, required String password}) async {
    // TODO: implement login
    try {
      final response = await _apiService.post(EndPoints.login, {
        "username": userName,
        "password": password,
      });
      final result = ResponseAuth.fromJson(response);
      await SecureStorageService.instance
          .setValue(key: ApiKeys.accessToken, value: result.data!.token!);
      await SecureStorageService.instance
          .setValue(key: ApiKeys.user, value: result.data!.toJson());
      MyLogger.instance.printLog('login success');
      MyLogger.instance.printLog('token ${result.data?.token}');
      return Right(result);
    } on ServerException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(success: false, error: Error(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ResponseAuth>> register(
      {required String userName,
      required String password,
      required String email,
      required String phone}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
