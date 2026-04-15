import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/core/apis/api/api_services.dart';
import 'package:mobile_app/core/apis/api/dio_services.dart';
import 'package:mobile_app/core/services/auth_service.dart';
import 'package:mobile_app/core/storage/pref_services.dart';
import 'package:mobile_app/core/storage/secure_storage_service.dart';
import 'package:mobile_app/features/auth/provider/auth_provider.dart';
import 'package:mobile_app/features/auth/repository/auth_repository.dart';
import 'package:mobile_app/features/splash%20copy/splash_injections.dart';

GetIt sl = GetIt.instance;

Future<void> appInjections() async {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<http.Client>(() => http.Client());
  final PrefServices prefServices = PrefServices();
  sl.registerLazySingleton(() => prefServices);
  final SecureStorageService secureStorageService = SecureStorageService();
  sl.registerLazySingleton(() => secureStorageService);

  sl.registerLazySingleton<ApiServices>(() => DioServices(dio: sl()));

  // 👇 ضيف ده
  sl.registerLazySingleton<AuthService>(() => AuthService(sl()));

  //* Auth
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(
        apiService: sl(),
      ));

  sl.registerLazySingleton<AuthProvider>(
      () => AuthProvider(authRepository: sl(), authService: sl()));

  splashInjections();
}
