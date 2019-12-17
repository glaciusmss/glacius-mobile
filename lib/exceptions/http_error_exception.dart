import 'package:dio/dio.dart';
import 'package:glacius_mobile/models/models.dart';

class HttpErrorException extends DioError {
  final message;
  final GeneralError generalError;

  HttpErrorException([this.message, this.generalError]);

  String toString() {
    if (generalError != null) {
      return generalError.message;
    }

    return super.toString();
  }
}
