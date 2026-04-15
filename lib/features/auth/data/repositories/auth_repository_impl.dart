import 'package:dartz/dartz.dart';
import 'package:mobile_app/core/apis/error/failure.dart';
import 'package:mobile_app/core/services/auth_service.dart';
import 'package:mobile_app/features/auth/data/datasource/data_source_remote.dart';
import 'package:mobile_app/features/auth/data/mapper/auth_mapper.dart';
import 'package:mobile_app/features/auth/data/models/response_auth.dart';
import 'package:mobile_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:mobile_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required DataSourceRemote remoteDataSource,
    required AuthService authService,
  })  : _remote = remoteDataSource,
        _authService = authService;

  final DataSourceRemote _remote;
  final AuthService _authService;

  Exception _exceptionFromFailure(Failure failure) {
    final msg = failure.error?.message?.toString() ?? 'حدث خطأ';
    return Exception(msg);
  }

  Future<void> _persistSession(ResponseAuth response) async {
    final token = response.data?.token;
    if (token == null || token.isEmpty) return;

    final u = response.data?.user;
    final userMap = <String, dynamic>{
      if (u?.id != null) 'id': u!.id,
      'fullName': u?.fullName ?? u?.username ?? '',
      'name': u?.fullName ?? u?.username ?? '',
      if (u?.phone != null) 'phone': u!.phone,
      if (u?.email != null) 'email': u!.email,
    };

    await _authService.saveAuthData({
      'token': token,
      'user': userMap,
    });
  }

  @override
  Future<Either<Failure, AuthUserEntityData>> login({
    required String username,
    required String password,
  }) async {
    final result = await _remote.login(userName: username, password: password);
    return result.map((m)=>m.toEntity());
  }

  @override
  Future<bool> resendOtp(String phone) async {
    final result = await _remote.resendOtp(phone);
    return result.fold<Future<bool>>(
      (failure) async {
        throw _exceptionFromFailure(failure);
      },
      (_) async => true,
    );
  }

  @override
  Future<bool> sendOtp({
    required String fullName,
    required String phone,
    required String relationType,
    required bool agreedToTerms,
  }) async {
    final result = await _remote.sendOtp(
      fullName: fullName,
      phone: phone,
      relationType: relationType,
      agreedToTerms: agreedToTerms,
    );
    return result.fold<Future<bool>>(
      (failure) async {
        throw _exceptionFromFailure(failure);
      },
      (_) async => true,
    );
  }

  @override
  Future<bool> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    final result = await _remote.verifyOtp(phone: phone, otp: otp);
    return result.fold<Future<bool>>(
      (failure) async {
        throw _exceptionFromFailure(failure);
      },
      (r) async {
        if (r.data?.token != null && r.data!.token!.isNotEmpty) {
          await _persistSession(r);
        }
        return true;
      },
    );
  }

  @override
  Future<void> logout() async {
    final token = _authService.getToken();
    if (token != null) {
      await _remote.logout(token: token);
    }
    await _authService.logout();
  }

  @override
  Future<AuthUserEntity?> getCurrentUser() async {
    // final user = _authService.getUser();
    // if (user == null) return null;
    // return AuthUserEntity(
    //   id: (user['id'] ?? '').toString(),
    //   name: (user['fullName'] ?? user['name'] ?? '').toString(),
    //   phone: (user['phone'] ?? '').toString(),
    //   email: user['email']?.toString(),
    // );
    throw UnimplementedError();
  }

  @override
  Future<bool> updateProfile({String? fullName, String? email}) async {
    final token = _authService.getToken();
    if (token == null) {
      throw Exception('غير مسجل الدخول');
    }

    final result = await _remote.updateProfile(
      token: token,
      fullName: fullName,
      email: email,
    );

    return result.fold<Future<bool>>(
      (failure) async {
        throw _exceptionFromFailure(failure);
      },
      (_) async {
        await _authService.updateProfile(fullName: fullName, email: email);
        return true;
      },
    );
  }

  @override
  bool isLoggedIn() {
    return _authService.isLoggedIn();
  }
}
