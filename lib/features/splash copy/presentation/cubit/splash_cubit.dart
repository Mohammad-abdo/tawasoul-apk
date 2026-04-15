import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app/core/classes/location_service.dart';
import 'package:mobile_app/features/splash%20copy/data/models/cases_enum.dart';
import 'package:mobile_app/features/splash%20copy/data/repositories/app_repository_impl.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.repository,
    required this.locationService,
    //required this.locationCubit,
  }) : super(SplashInitial());

  final AppRepository repository;
  final LocationService locationService;
  //final LocationCubit locationCubit;

  Future<void> startApp() async {
    await Future.delayed(const Duration(seconds: 1));

    // لا نطلب اللوكيشن في الـ splash — سيُطلب أثناء اللوجن (بوتوم شيت اللوكيشن)
    // var hasLocationPermission = await locationService.checkPermission();
    // if (!hasLocationPermission) {
    //   hasLocationPermission = await locationService.requestPermission();
    //   if (!hasLocationPermission) {
    //     emit(SplashPermissionDenied());
    //     return;
    //   }
    //   await locationCubit.getCurrentLocation();
    // }

    await _proceedToFlow();
  }

  Future<void> openSettings() async {
    await locationService.openLocationSettings();
  }

  Future<void> retryPermission() async {
    //final granted = await locationService.requestPermission();
    //if (granted) {
      //await locationCubit.getCurrentLocation();
      await _proceedToFlow();
   // }
  }

  Future<void> _proceedToFlow() async {
    final flow = await repository.checkAppFlow();
    emit(SplashNavigate(flow));
  }
}
