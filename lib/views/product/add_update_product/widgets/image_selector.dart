import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glacius_mobile/views/product/add_update_product/widgets/image_source_selector.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatelessWidget {
  final Function(File) onSelected;

  ImageSelector({@required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      child: FlatButton(
        padding: EdgeInsets.zero,
        color: Color(0xffF5F5F5),
        child: Icon(Icons.add, size: 40.0),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ImageSourceSelector(
                onSelected: (ImageSource selectedSource) async {
                  File image = await ImagePicker.pickImage(
                    source: selectedSource,
                  );

                  if (image != null) {
                    onSelected(image);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
