import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/models/models.dart' as model;
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ImageItem extends StatefulWidget {
  final model.Image image;
  final GestureTapCallback onTap;
  final Function(model.Image uploadedImage) onImageUploaded;
  final Function(model.Image loadedNetworkImage) onNetworkImageLoaded;
  final GestureLongPressCallback onLongPress;
  final double width;
  final double height;

  ImageItem({
    @required this.image,
    @required this.onTap,
    @required this.onImageUploaded,
    this.onNetworkImageLoaded,
    this.onLongPress,
    this.width = 80.0,
    this.height = 80.0,
  });

  @override
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  double uploadProgress = 0;
  bool isLongPressed = false;
  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();

    if (_isNetworkImage()) {
      _loadNetworkImage();
    }

    if (!_isLocalImageUploaded()) {
      _uploadImage();
    }
  }

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          decoration: isLongPressed
              ? BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                )
              : null,
          child: Hero(
            tag: widget.image.tag,
            child: _buildThumbnail(),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (_isLocalImageUploaded() || _isNetworkImageLoaded())
                  ? widget.onTap
                  : null,
              onLongPress: (_isLocalImageUploaded() || _isNetworkImageLoaded())
                  ? _onLongPress
                  : null,
            ),
          ),
        ),
        //show loading indicator when uploading
        if (!_isNetworkImage() && !_isLocalImageUploaded())
          Spinner.configured(
            context,
            value: uploadProgress,
            color: Colors.black,
            backgroundColor: Colors.white,
          ),
      ],
    );
  }

  Widget _buildThumbnail() {
    if (_isLocalImage()) {
      return Opacity(
        opacity: _isLocalImageUploaded() ? 1.0 : 0.3,
        child: Image.file(
          widget.image.tempImage,
          fit: BoxFit.fill,
          height: widget.height,
          width: widget.width,
        ),
      );
    }

    if (_isNetworkImageLoaded()) {
      return CachedNetworkImage(
        imageUrl: widget.image.url,
        fit: BoxFit.fill,
        height: widget.height,
        width: widget.width,
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }

  bool _isLocalImage() {
    return widget.image.tempImage != null;
  }

  bool _isLocalImageUploaded() {
    return _isLocalImage() && widget.image.fileName != null;
  }

  bool _isNetworkImage() {
    return !_isLocalImage() &&
        (widget.image.fileName != null || widget.image.url != null);
  }

  bool _isNetworkImageLoaded() {
    return _isNetworkImage() && widget.image.url != null;
  }

  void _loadNetworkImage() async {
    final imageRepository = RepositoryProvider.of<ImageRepository>(context);
    try {
      model.Image image = await imageRepository.getImage(
        image: widget.image.fileName,
        cancelToken: cancelToken,
      );

      widget.onNetworkImageLoaded(image.copyWith(tag: widget.image.tag));
    } catch (error) {
      //TODO: handle image load error
    }
  }

  void _uploadImage() async {
    ImageRepository imageRepository = RepositoryProvider.of<ImageRepository>(
      context,
    );

    try {
      String imageFileName = await imageRepository.uploadImage(
        image: widget.image,
        onSendProgress: _onUploadProgress,
        cancelToken: cancelToken,
      );

      widget.onImageUploaded(
        widget.image.copyWith(fileName: imageFileName),
      );
    } catch (error) {
      //TODO: handler upload error
    }
  }

  void _onUploadProgress(int sent, int total) {
    setState(() {
      uploadProgress = sent / total;
    });
  }

  void _onLongPress() async {
    setState(() {
      isLongPressed = true;
    });

    await widget.onLongPress();

    setState(() {
      isLongPressed = false;
    });
  }
}
