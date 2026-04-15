import 'package:mobile_app/features/splash%20copy/data/datasources/app_local_datasource.dart';
import 'package:mobile_app/features/splash%20copy/data/models/cases_enum.dart';

class AppRepository {
  final AppLocalDataSource local;

  AppRepository(this.local);

  Future<void> setOnBoardingSeen() async {
    await local.setOnboardingSeen();
  }

  Future<AppFlow> checkAppFlow() async {
    // التحقق من اللغة أولاً - تظهر مرة واحدة فقط
    //final isLanguageSelected = await local.isLanguageSelected();
    // if (!isLanguageSelected) {
    //   return AppFlow.language;
    // }

    final isOnboardingSeen = await local.isOnboardingSeen();
    final token = await local.getToken();
    if (!isOnboardingSeen) {
      return AppFlow.onboard;
    }

    if (token == null || token.isEmpty) {
      return AppFlow.login;
    }

    return AppFlow.home;
  }
}
