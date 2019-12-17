import 'package:flutter/material.dart';
import 'package:glacius_mobile/models/models.dart' as model;

class ImageThumbnail extends StatelessWidget {
  final model.Image image;
  final GestureTapCallback onTap;

  ImageThumbnail({@required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF5F5F5),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: this.image.fileName,
          child: Image.network(image.url, height: 80.0, width: 80.0),
        ),
      ),
    );
  }
}
