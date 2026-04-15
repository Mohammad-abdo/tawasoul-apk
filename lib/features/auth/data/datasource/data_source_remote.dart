import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/apis/api/api_services.dart';
import 'package:mobile_app/core/apis/error/failure.dart';
import 'package:mobile_app/core/apis/error/server_exception.dart';
import 'package:mobile_app/core/apis/links/api_keys.dart';
import 'package:mobile_app/core/apis/links/end_points.dart';
import 'package:mobile_app/core/classes/my_logger.dart';
import 'package:mobile_app/core/config/app_config.dart';
import 'package:mobile_app/core/services/api_service.dart';
import 'package:mobile_app/core/storage/secure_storage_service.dart';
import 'package:mobile_app/features/auth/data/models/response_auth.dart';

/// Remote auth API (Tawasoul — [AppConfig] base URL + Postman §1 paths).
/// Adjust request/response field names to match your backend contract.
abstract class DataSourceRemote {
  Future<Either<Failure, AuthData>> login({
    required String userName,
    required String password,
  });

  Future<Either<Failure, ResponseAuth>> register({
    required String userName,
    required String password,
    required String email,
    required String phone,
  });

  Future<Either<Failure, Unit>> sendOtp({
    required String fullName,
    required String phone,
    required String relationType,
    required bool agreedToTerms,
  });

  Future<Either<Failure, ResponseAuth>> verifyOtp({
    required String phone,
    required String otp,
  });

  Future<Either<Failure, Unit>> resendOtp(String phone);

  Future<Either<Failure, Unit>> logout({required String token});

  Future<Either<Failure, Unit>> updateProfile({
    required String token,
    String? fullName,
    String? email,
  });
}

class DataSourceRemoteImp implements DataSourceRemote {
  DataSourceRemoteImp({required ApiServices apiService}) : _api = apiService;

  final ApiServices _api;

  Failure _failureFromObject(Object e) {
    final msg = e.toString().replaceFirst('Exception: ', '');
    return Failure(success: false, error: Error(message: msg));
  }

  @override
  Future<Either<Failure, AuthData>> login(
      {required String userName, required String password}) async {
    // TODO: implement login
    try {
      final response = await _api.post(EndPoints.login, data: {
        "username": userName,
        "password": password,
      });
      final result = ResponseAuth.fromJson(response.data);
      MyLogger.instance.printLog('login response: ${result}');
      final authData = result.data;
      await SecureStorageService.instance
          .setValue(key: ApiKeys.accessToken, value: authData!.token!);
      // await SecureStorageService.instance
      //     .setValue(key: ApiKeys.user, value: authData);
      MyLogger.instance.printLog('login success');
      MyLogger.instance.printLog('token ${result.data?.token}');
      return Right(authData);
    } on ServerException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(success: false, error: Error(message: e.toString())));
    }
  }

  // @override
  // Future<Either<Failure, ResponseAuth>> register(
  //     {required String userName,
  //     required String password,
  //     required String email,
  //     required String phone}) {
  //   // TODO: implement register
  //   throw UnimplementedError();
  // }
  @override
  Future<Either<Failure, ResponseAuth>> register({
    required String userName,
    required String password,
    required String email,
    required String phone,
  }) async {
    MyLogger.instance
        .printLog('🔵 DataSourceRemote: POST ${AppConfig.registerEndpoint}');
    try {
      final raw = await _api.post(EndPoints.register, data: {
        'username': userName,
        'password': password,
        'email': email,
        'phone': phone,
      });
      final result = ResponseAuth.fromJson(raw.data);
      MyLogger.instance.printLog('✅ DataSourceRemote: register success');
      return Right(result);
    } catch (e) {
      MyLogger.instance.printLog('❌ DataSourceRemote: register error $e');
      return Left(_failureFromObject(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendOtp({
    required String fullName,
    required String phone,
    required String relationType,
    required bool agreedToTerms,
  }) async {
    MyLogger.instance
        .printLog('🔵 DataSourceRemote: POST ${AppConfig.sendOtpEndpoint}');
    try {
      await _api.post(EndPoints.sendOtp, data: {
        'fullName': fullName,
        'phone': phone,
        'relationType': relationType,
        'agreedToTerms': agreedToTerms,
      });
      MyLogger.instance.printLog('✅ DataSourceRemote: sendOtp success');
      return const Right(unit);
    } catch (e) {
      MyLogger.instance.printLog('❌ DataSourceRemote: sendOtp error $e');
      return Left(_failureFromObject(e));
    }
  }

  @override
  Future<Either<Failure, ResponseAuth>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    MyLogger.instance
        .printLog('🔵 DataSourceRemote: POST ${AppConfig.verifyOtpEndpoint}');
    try {
      final raw = await _api.post(EndPoints.driverStaticTerms,data:  {
        'phone': phone,
        'otp': otp,
      });
      final result = ResponseAuth.fromJson(raw.data);
      MyLogger.instance.printLog('✅ DataSourceRemote: verifyOtp success');
      return Right(result);
    } catch (e) {
      MyLogger.instance.printLog('❌ DataSourceRemote: verifyOtp error $e');
      return Left(_failureFromObject(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> resendOtp(String phone) async {
    MyLogger.instance
        .printLog('🔵 DataSourceRemote: POST ${AppConfig.resendOtpEndpoint}');
    try {
      await _api.post(EndPoints.resendOtp,data:  {
        'phone': phone,
      });
      MyLogger.instance.printLog('✅ DataSourceRemote: resendOtp success');
      return const Right(unit);
    } catch (e) {
      MyLogger.instance.printLog('❌ DataSourceRemote: resendOtp error $e');
      return Left(_failureFromObject(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout({required String token}) async {
    MyLogger.instance
        .printLog('🔵 DataSourceRemote: POST ${AppConfig.logoutEndpoint}');
    try {
      await _api.post(EndPoints.logOut, data: {
        'token': token,
      });
      MyLogger.instance.printLog('✅ DataSourceRemote: logout success');
      return const Right(unit);
    } catch (e) {
      MyLogger.instance.printLog('❌ DataSourceRemote: logout error $e');
      return Left(_failureFromObject(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfile({
    required String token,
    String? fullName,
    String? email,
  }) async {
    MyLogger.instance.printLog(
        '🔵 DataSourceRemote: PUT ${AppConfig.updateProfileEndpoint}');
    try {
      final body = <String, dynamic>{};
      if (fullName != null) body['fullName'] = fullName;
      if (email != null) body['email'] = email;
      await _api.put(EndPoints.profileUpdate, data: body,);
      MyLogger.instance.printLog('✅ DataSourceRemote: updateProfile success');
      return const Right(unit);
    } catch (e) {
      MyLogger.instance.printLog('❌ DataSourceRemote: updateProfile error $e');
      return Left(_failureFromObject(e));
    }
  }
}
