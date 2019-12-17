import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/services/services.dart';

class ImageRepository {
  ImageApiService _imageApiService;

  ImageRepository({ImageApiService imageApiService}) {
    imageApiService ??= ImageApiService();

    this._imageApiService = imageApiService;
  }

  Future<Image> getImage({
    @required String image,
    CancelToken cancelToken,
  }) async {
    Map data = await this._imageApiService.getImage(
          image: image,
          cancelToken: cancelToken,
        );

    return Image.fromJson(data);
  }

  Future<String> uploadImage({
    @required Image image,
    ProgressCallback onSendProgress,
    CancelToken cancelToken,
  }) async {
    Map data = await this._imageApiService.uploadImage(
          image: image,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken,
        );

    return data['file'];
  }
}
