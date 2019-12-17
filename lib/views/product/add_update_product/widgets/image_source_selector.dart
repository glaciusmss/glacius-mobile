import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSelector extends StatelessWidget {
  final Function(ImageSource) onSelected;

  ImageSourceSelector({@required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Add Image'),
      children: <Widget>[
        SimpleDialogOption(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Take photo'),
          ),
          onPressed: () {
            onSelected(ImageSource.camera);
            Navigator.of(context).pop();
          },
        ),
        SimpleDialogOption(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Choose from gallery'),
          ),
          onPressed: () {
            onSelected(ImageSource.gallery);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
