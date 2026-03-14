import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';

/// Auth service: all operations are local only (API connection disabled).
class AuthService {
  final SharedPreferences prefs;
  
  AuthService(this.prefs);
  
  Future<Map<String, dynamic>> sendOtp({
    required String fullName,
    required String phone,
    required String relationType,
    required bool agreedToTerms,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return {'success': true, 'data': null};
  }
  
  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return {'success': true, 'data': null};
  }
  
  Future<Map<String, dynamic>> resendOtp(String phone) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return {'success': true};
  }

  Future<void> logout() async {
    await clearAuthData();
  }

  Future<Map<String, dynamic>?> getMe() async {
    return getUser();
  }

  Future<Map<String, dynamic>> updateProfile({
    String? fullName,
    String? email,
  }) async {
    final user = getUser();
    if (user == null) throw Exception('Not authenticated');
    if (fullName != null) user['fullName'] = fullName;
    if (email != null) user['email'] = email;
    await prefs.setString(AppConfig.keyUserData, jsonEncode(user));
    return {'success': true, 'data': user};
  }

  Future<void> saveAuthData(Map<String, dynamic> data) async {
    if (data['token'] != null) {
      await prefs.setString(AppConfig.keyAuthToken, data['token']);
    }
    if (data['user'] != null) {
      await prefs.setString(AppConfig.keyUserData, jsonEncode(data['user']));
    }
  }
  
  Future<void> clearAuthData() async {
    await prefs.remove(AppConfig.keyAuthToken);
    await prefs.remove(AppConfig.keyUserData);
  }
  
  /// Save token directly (for mock authentication)
  Future<void> saveToken(String token) async {
    await prefs.setString(AppConfig.keyAuthToken, token);
  }
  
  /// Clear token (for logout)
  Future<void> clearToken() async {
    await prefs.remove(AppConfig.keyAuthToken);
  }
  
  bool isLoggedIn() {
    return prefs.getString(AppConfig.keyAuthToken) != null;
  }
  
  String? getToken() {
    return prefs.getString(AppConfig.keyAuthToken);
  }
  
  Map<String, dynamic>? getUser() {
    final userJson = prefs.getString(AppConfig.keyUserData);
    if (userJson != null) {
      return jsonDecode(userJson) as Map<String, dynamic>;
    }
    return null;
  }
}

