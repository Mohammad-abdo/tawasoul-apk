import 'package:mobile_app/core/constants/app_strings.dart';
import 'package:mobile_app/core/storage/pref_services.dart';

bool get isDark {
  return PrefServices.instance.getData(key: AppStrings.isDark) ?? false;
}
