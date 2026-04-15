import 'package:get_it/get_it.dart';
import 'package:mobile_app/features/auth/data/datasource/data_source_remote.dart';
import 'package:mobile_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_app/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/logout_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/send_otp_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/update_profile_use_case.dart';
import 'package:mobile_app/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:mobile_app/features/auth/presentation/cubit/auth_cubit.dart';

/// Auth feature: remote data source, repository, use cases, cubits.
/// Requires [ApiService] and [AuthService] on `GetIt` (see `core/di.dart`).
void registerAuthDependencies(GetIt sl) {
  if (!sl.isRegistered<DataSourceRemote>()) {
    sl.registerLazySingleton<DataSourceRemote>(
      () => DataSourceRemoteImp(apiService: sl()),
    );
  }

  if (!sl.isRegistered<AuthRepository>()) {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl(),
        authService: sl(),
      ),
    );
  }

  if (!sl.isRegistered<LoginUseCase>()) {
    sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  }
  if (!sl.isRegistered<SendOtpUseCase>()) {
    sl.registerLazySingleton<SendOtpUseCase>(() => SendOtpUseCase(sl()));
  }
  if (!sl.isRegistered<VerifyOtpUseCase>()) {
    sl.registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(sl()));
  }
  if (!sl.isRegistered<ResendOtpUseCase>()) {
    sl.registerLazySingleton<ResendOtpUseCase>(() => ResendOtpUseCase(sl()));
  }
  if (!sl.isRegistered<LogoutUseCase>()) {
    sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl()));
  }
  if (!sl.isRegistered<GetCurrentUserUseCase>()) {
    sl.registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(sl()),
    );
  }
  if (!sl.isRegistered<UpdateProfileUseCase>()) {
    sl.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(sl()),
    );
  }

  if (!sl.isRegistered<AuthCubit>()) {
    sl.registerFactory<AuthCubit>(
      () => AuthCubit(
        loginUseCase: sl(),
        sendOtpUseCase: sl(),
        verifyOtpUseCase: sl(),
        resendOtpUseCase: sl(),
        logoutUseCase: sl(),
        getCurrentUserUseCase: sl(),
        updateProfileUseCase: sl(),
      ),
    );
  }
}
