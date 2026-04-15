import 'package:flutter/foundation.dart';
import 'package:mobile_app/features/auth/repository/auth_repository.dart';
import '../../../core/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  final AuthRepository _authRepository;

  AuthProvider(
      {required AuthRepository authRepository,
      required AuthService authService})
      : _authService = authService,
        _authRepository = authRepository;

  bool _isLoading = false;
  String? _error;
  bool _isAuthenticated = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _isAuthenticated;

  Future<T?> _handleRequest<T>(Future<T> Function() request) async {
    if (_isLoading) return null;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      return await request();
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// MOCK - Send OTP (Registration) - No backend required
  Future<bool> sendOtp({
    required String fullName,
    required String phone,
    required String relationType,
    required bool agreedToTerms,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock: Always succeed if valid data
      if (fullName.isNotEmpty && phone.length >= 11 && agreedToTerms) {
        _isLoading = false;
        notifyListeners();
        return true;
      }

      _error = 'يرجى التحقق من البيانات المدخلة';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// MOCK - Verify OTP - No backend required
  Future<bool> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    final result = await _handleRequest<bool>(() async {
      await Future.delayed(const Duration(milliseconds: 800));

      if (otp.length != 4) {
        throw Exception('رمز التحقق غير صحيح');
      }

      await _authService.saveAuthData({
        'token': 'MOCK_OTP_${DateTime.now().millisecondsSinceEpoch}',
        'user': {
          'id': 'mock_user_otp',
          'name': 'مستخدم جديد',
          'phone': phone,
        },
      });

      _isAuthenticated = true;

      return true;
    });

    return result ?? false;
  }
  // Future<bool> verifyOtp({
  //   required String phone,
  //   required String otp,
  // }) async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     // Simulate network delay
  //     await Future.delayed(const Duration(milliseconds: 800));

  //     // Mock: Accept any 4-digit OTP
  //     if (otp.length == 4) {
  //       // Save mock auth data
  //       await _authService.saveAuthData({
  //         'token': 'MOCK_OTP_${DateTime.now().millisecondsSinceEpoch}',
  //         'user': {
  //           'id': 'mock_user_otp',
  //           'name': 'مستخدم جديد',
  //           'phone': phone,
  //           'role': 'PARENT',
  //         },
  //       });

  //       _isAuthenticated = true;
  //       _isLoading = false;
  //       notifyListeners();
  //       return true;
  //     }

  //     _error = 'رمز التحقق غير صحيح';
  //     _isLoading = false;
  //     notifyListeners();
  //     return false;
  //   } catch (e) {
  //     _error = e.toString();
  //     _isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }
  // }

  /// MOCK - Resend OTP - No backend required
  Future<bool> resendOtp(String phone) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Login with email or phone + password. For existing users.
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    final result = await _handleRequest<bool>(() async {
      final response =
          await _authRepository.login(userName: username, password: password);
      response.fold((failure) => failure, (data) => data);

      _isAuthenticated = true;

      return true;
    });

    return result ?? false;
  }
  // Future<bool> login({
  //   required String identifier,
  //   required String password,
  // }) async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();
  //   try {
  //     await Future.delayed(const Duration(milliseconds: 800));
  //     await _authService.saveAuthData({
  //       'token': 'MOCK_LOGIN_${DateTime.now().millisecondsSinceEpoch}',
  //       'user': {
  //         'id': 'mock_user_login',
  //         'name': 'مستخدم',
  //         'phone': identifier,
  //         'role': 'PARENT',
  //       },
  //     });
  //     _isAuthenticated = true;
  //     _isLoading = false;
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     _error = e.toString();
  //     _isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }
  // }

  /// Logout (Postman 1.4). Calls backend then clears local.
  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    _error = null;
    notifyListeners();
  }

  /// Current user from storage. Use refreshUser() to sync from backend (Postman 1.5).
  Map<String, dynamic>? get user => _authService.getUser();

  /// GET /user/auth/me — refresh user from backend.
  Future<void> refreshUser() async {
    final u = await _authService.getMe();
    if (u != null) notifyListeners();
  }

  /// PUT /user/auth/profile (Postman 1.6).
  Future<bool> updateProfile({String? fullName, String? email}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _authService.updateProfile(fullName: fullName, email: email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
