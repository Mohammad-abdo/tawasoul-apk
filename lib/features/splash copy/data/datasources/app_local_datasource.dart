

import 'package:mobile_app/core/apis/links/api_keys.dart';
import 'package:mobile_app/core/constants/app_strings.dart';
import 'package:mobile_app/core/storage/pref_services.dart';
import 'package:mobile_app/core/storage/secure_storage_service.dart';

class AppLocalDataSource {
  final PrefServices prefServices;
  final SecureStorageService secureStorageService;

  AppLocalDataSource({
    required this.prefServices,
    required this.secureStorageService,
  });

 

  Future<bool> isOnboardingSeen() async =>
      prefServices.getData(key: AppStrings.isOnboard) ?? false;

  Future<void> setOnboardingSeen() async {
    await prefServices.saveData(key: AppStrings.isOnboard, value: true);
  }

  /// True if user finished first-time language flow.
  /// Also treats saved [AppStrings.appLanguage] as done (older builds never set the flag).
  Future<bool> isLanguageSelected() async {
    final flag = prefServices.getData(key: AppStrings.isLanguageSelected);
    if (flag == true) return true;
    final lang = prefServices.getData(key: AppStrings.appLanguage);
    return lang != null &&
        lang is String &&
        lang.isNotEmpty;
  }

  Future<void> setLanguageSelected() async {
    await prefServices.saveData(key: AppStrings.isLanguageSelected, value: true);
  }

  Future<String?> getToken() async =>
      secureStorageService.getValue(key: ApiKeys.accessToken);
}
