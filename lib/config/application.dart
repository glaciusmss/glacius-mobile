import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application {
  static PackageInfo packageInfo;
  static String baseUrl;

  static Future<void> load() async {
    await DotEnv().load('.env');
    await Future.wait([
      loadPackageInfo(),
      loadBaseUrlFromSP(),
    ]);
  }

  static Future<void> loadPackageInfo() async {
    Application.packageInfo = await PackageInfo.fromPlatform();
  }

  static Future<void> loadBaseUrlFromSP() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.containsKey("APP_URL")) {
      Application.baseUrl = sp.getString('APP_URL');
    } else {
      Application.baseUrl = DotEnv().env['APP_URL'];
    }

    Request().createDioClient();
  }
}
