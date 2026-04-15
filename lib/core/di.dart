import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app/core/services/api_service.dart';
import 'package:mobile_app/core/services/auth_service.dart';
import 'package:mobile_app/features/auth/auth_dependencies.dart';

final GetIt sl = GetIt.instance;

/// App-wide DI bootstrap. Registers shared services, then each feature module.
Future<void> setupDependencies() async {
  if (!sl.isRegistered<SharedPreferences>()) {
    final prefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => prefs);
  }

  if (!sl.isRegistered<AuthService>()) {
    sl.registerLazySingleton<AuthService>(() => AuthService(sl()));
  }

  if (!sl.isRegistered<ApiService>()) {
    sl.registerLazySingleton<ApiService>(() => ApiService());
  }

  registerAuthDependencies(sl);
}
