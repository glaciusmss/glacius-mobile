import 'package:package_info/package_info.dart';

class Application {
  static PackageInfo packageInfo;

  static Future<void> loadPackageInfo() async {
    Application.packageInfo = await PackageInfo.fromPlatform();
  }
}
