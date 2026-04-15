import 'package:mobile_app/core/di.dart';
import 'package:mobile_app/features/splash%20copy/data/datasources/app_local_datasource.dart';
import 'package:mobile_app/features/splash%20copy/data/repositories/app_repository_impl.dart';
import 'package:mobile_app/features/splash%20copy/presentation/cubit/splash_cubit.dart';

void splashInjections() {
  // LocationService is registered in locationInjection()
  sl.registerLazySingleton<AppLocalDataSource>(
    () => AppLocalDataSource(prefServices: sl(), secureStorageService: sl()),
  );
  sl.registerLazySingleton<AppRepository>(() => AppRepository(sl()));
  sl.registerFactory<SplashCubit>(
    () => SplashCubit(
      repository: sl(),
      locationService: sl(),
      //locationCubit: sl<LocationCubit>(),
    ),
  );
}
