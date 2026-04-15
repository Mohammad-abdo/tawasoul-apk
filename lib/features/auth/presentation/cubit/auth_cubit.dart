import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/apis/links/api_keys.dart';
import 'package:mobile_app/core/enums/request_status.dart';
import 'package:mobile_app/core/storage/secure_storage_service.dart';
import 'package:mobile_app/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/logout_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/send_otp_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/update_profile_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:mobile_app/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  AuthCubit(
      {required LoginUseCase loginUseCase,
      required SendOtpUseCase sendOtpUseCase,
      required VerifyOtpUseCase verifyOtpUseCase,
      required ResendOtpUseCase resendOtpUseCase,
      required LogoutUseCase logoutUseCase,
      required GetCurrentUserUseCase getCurrentUserUseCase,
      required UpdateProfileUseCase updateProfileUseCase})
      : _loginUseCase = loginUseCase,
        _sendOtpUseCase = sendOtpUseCase,
        _verifyOtpUseCase = verifyOtpUseCase,
        _resendOtpUseCase = resendOtpUseCase,
        _logoutUseCase = logoutUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        super(const AuthState());

  // AuthCubit({
  //   required this.loginUseCase,
  //   required this.sendOtpUseCase,
  //   required this.verifyOtpUseCase,
  //   required this.resendOtpUseCase,
  //   required this.logoutUseCase,
  //   required this.getCurrentUserUseCase,
  //   required this.updateProfileUseCase,
  // }) : super(const AuthState());

  Future<void> loadAuthStatus() async {
    final token = await SecureStorageService.instance.getValue(key: ApiKeys.accessToken);
    if (token == null || token.isEmpty) {
      emit(state.copyWith(isAuthenticated: false));
      return;
    }
    final user = await _getCurrentUserUseCase();
    emit(
      state.copyWith(
        isAuthenticated: user != null,
        user: user,
        clearError: true,
      ),
    );
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(
        state.copyWith(requestStatus: RequestStatus.loading, clearError: true));
    final response =
        await _loginUseCase.call(username: username, password: password);
    response.fold(
      (failure) => emit(state.copyWith(
        requestStatus: RequestStatus.failure,
        error: failure.error?.message,
      )),
      (data) => emit(
        state.copyWith(
          requestStatus: RequestStatus.success,
          user: data.user,
          isAuthenticated: data.user != null,
        ),
      ),
    );
  }

  Future<bool> sendOtp({
    required String fullName,
    required String phone,
    required String relationType,
    required bool agreedToTerms,
  }) async {
    emit(
        state.copyWith(requestStatus: RequestStatus.loading, clearError: true));
    try {
      final ok = await _sendOtpUseCase(
        fullName: fullName,
        phone: phone,
        relationType: relationType,
        agreedToTerms: agreedToTerms,
      );
      emit(state.copyWith(requestStatus: RequestStatus.success));
      return ok;
    } catch (e) {
      emit(state.copyWith(
          requestStatus: RequestStatus.failure, error: e.toString()));
      return false;
    }
  }

  Future<bool> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    emit(
        state.copyWith(requestStatus: RequestStatus.loading, clearError: true));
    try {
      final ok = await _verifyOtpUseCase(phone: phone, otp: otp);
      final user = await _getCurrentUserUseCase();
      emit(
        state.copyWith(
          requestStatus: RequestStatus.success,
          isAuthenticated: ok,
          user: user,
        ),
      );
      return ok;
    } catch (e) {
      emit(state.copyWith(
          requestStatus: RequestStatus.failure, error: e.toString()));
      return false;
    }
  }

  Future<bool> resendOtp(String phone) async {
    emit(
        state.copyWith(requestStatus: RequestStatus.loading, clearError: true));
    try {
      final ok = await _resendOtpUseCase(phone);
      emit(state.copyWith(requestStatus: RequestStatus.success));
      return ok;
    } catch (e) {
      emit(state.copyWith(
          requestStatus: RequestStatus.failure, error: e.toString()));
      return false;
    }
  }

  Future<void> logout() async {
    emit(
        state.copyWith(requestStatus: RequestStatus.loading, clearError: true));
    await _logoutUseCase();
    emit(
      state.copyWith(
        requestStatus: RequestStatus.success,
        isAuthenticated: false,
        clearUser: true,
      ),
    );
  }

  Future<bool> updateProfile({
    String? fullName,
    String? email,
  }) async {
    emit(
        state.copyWith(requestStatus: RequestStatus.loading, clearError: true));
    try {
      final ok = await _updateProfileUseCase(fullName: fullName, email: email);
      final user = await _getCurrentUserUseCase();
      emit(state.copyWith(requestStatus: RequestStatus.success, user: user));
      return ok;
    } catch (e) {
      emit(state.copyWith(
          requestStatus: RequestStatus.failure, error: e.toString()));
      return false;
    }
  }
}
