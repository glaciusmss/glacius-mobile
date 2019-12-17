import 'package:dio/dio.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:flutter/foundation.dart';

class ImageApiService {
  Request _request;

  ImageApiService({Request request}) {
    this._request = request ??= Request();
  }

  Future<dynamic> getImage({
    @required String image,
    CancelToken cancelToken,
  }) async {
    Response res = await this._request.client.get(
          '/image/' + image,
          cancelToken: cancelToken,
        );

    return res.data;
  }

  Future<dynamic> uploadImage({
    @required Image image,
    ProgressCallback onSendProgress,
    CancelToken cancelToken,
  }) async {
    Response res = await this._request.client.post(
          '/image',
          onSendProgress: onSendProgress,
          cancelToken: cancelToken,
          data: FormData.fromMap(
            {
              'file': await MultipartFile.fromFile(
                image.tempImage.path,
                filename: image.name,
              ),
            },
          ),
        );

    return res.data;
  }
}
