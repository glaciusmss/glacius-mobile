import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:laravel_echo/laravel_echo.dart';

class EchoHelper {
  Echo client;

  EchoHelper({@required String token}) {
    client = Echo({
      'broadcaster': 'pusher',
      'client': _getPusherClient(token),
    });
  }

  FlutterPusher _getPusherClient(String token) {
    PusherOptions options = PusherOptions(
      auth: PusherAuth(
        DotEnv().env['APP_URL'] + '/broadcasting/auth',
        headers: {
          'Authorization': 'Bearer ${token}',
          'Accept': 'application/json',
          'X-REQUEST-FROM': 'mobile',
        },
      ),
      cluster: DotEnv().env['PUSHER_APP_CLUSTER'],
    );

    return FlutterPusher(
      DotEnv().env['PUSHER_APP_KEY'],
      options,
      enableLogging: true,
    );
  }
}
