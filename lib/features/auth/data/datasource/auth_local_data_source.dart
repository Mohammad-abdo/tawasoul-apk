import 'package:mobile_app/core/services/auth_service.dart';

/// Legacy mock/local auth — not registered in DI. Auth uses [DataSourceRemote].
class AuthLocalDataSource {
  final AuthService authService;

  AuthLocalDataSource({required this.authService});

  Future<bool> sendOtp({
    required String fullName,
    required String phone,
    required String relationType,
    required bool agreedToTerms,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return fullName.isNotEmpty && phone.length >= 11 && agreedToTerms;
  }

  Future<bool> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (otp.length != 5) {
      throw Exception('رمز التحقق غير صحيح');
    }
    await authService.saveAuthData({
      'token': 'MOCK_OTP_${DateTime.now().millisecondsSinceEpoch}',
      'user': {
        'id': 'mock_user_otp',
        'name': 'مستخدم جديد',
        'phone': phone,
      },
    });
    return true;
  }

  Future<bool> resendOtp(String phone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (username.isEmpty || password.isEmpty) {
      throw Exception('بيانات تسجيل الدخول غير مكتملة');
    }
    await authService.saveAuthData({
      'token': 'MOCK_LOGIN_${DateTime.now().millisecondsSinceEpoch}',
      'user': {
        'id': 'mock_user_login',
        'name': username,
        'phone': username,
      },
    });
    return true;
  }
}
