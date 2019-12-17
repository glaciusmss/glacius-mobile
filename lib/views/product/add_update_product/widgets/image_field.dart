import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glacius_mobile/models/models.dart' as model;
import 'package:glacius_mobile/views/product/add_update_product/add_update_product.dart';
import 'package:glacius_mobile/views/product/add_update_product/widgets/widgets.dart';
import 'package:glacius_mobile/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class ImageField extends StatefulWidget {
  final List<String> imagesName;

  ImageField({this.imagesName});

  @override
  _ImageFieldState createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  List<model.Image> images = [];

  @override
  void initState() {
    super.initState();

    //set unloaded image to state
    setState(() {
      images = widget.imagesName?.map((String imageName) {
        return model.Image(
          fileName: imageName,
          tag: Uuid().v4(),
        );
      })?.toList() ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderCustomField(
      attribute: FormAttribute.images,
      formField: FormField(
        builder: (FormFieldState fieldState) {
          return Container(
            height: 80.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _buildImageItems(fieldState),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildImageItems(FormFieldState fieldState) {
    List<Widget> builtImageItems = [];

    //show all image from state
    images.asMap().forEach((int index, model.Image image) {
      builtImageItems
        ..addAll(<Widget>[
          ImageItem(
            image: image,
            onNetworkImageLoaded: _addLoadedNetworkImageToState,
            onImageUploaded: (model.Image uploadedImage) {
              _addUploadedImageToState(uploadedImage, fieldState);
            },
            onTap: () {
              _showPreview(index, fieldState: fieldState);
            },
            onLongPress: () {
              return _showLongPressedMenu(index, fieldState: fieldState);
            },
          ),
          SizedBox(width: 5.0),
        ]);
    });

    //add the add button at the end
    return builtImageItems
      ..add(
        ImageSelector(onSelected: _addNewImageToState),
      );
  }

  void _showPreview(int index, {FormFieldState fieldState}) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ImagePreview(
          images: images.where((image) => image.fileName != null).toList(),
          initialIndex: index,
          onImageDelete: (index, deletedImage) {
            return _onImageDeleted(index, deletedImage, fieldState);
          },
        );
      },
    ));
  }

  Future _showLongPressedMenu(int index, {FormFieldState fieldState}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () async {
                  bool isDeleted = await _onImageDeleted(
                    index,
                    images[index],
                    fieldState,
                  );
                  if (isDeleted) {
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  void _addNewImageToState(File newImage) {
    model.Image image = model.Image(
      name: newImage.path.split('/').last,
      tempImage: newImage,
      tag: Uuid().v4(),
    );

    setState(() {
      images = List<model.Image>.from(images)..add(image);
    });
  }

  void _addLoadedNetworkImageToState(model.Image loadedNetworkImage) {
    setState(() {
      images = images.map((model.Image imageState) {
        if (imageState.fileName == loadedNetworkImage.fileName) {
          return loadedNetworkImage;
        }
        return imageState;
      }).toList();
    });
  }

  void _addUploadedImageToState(
    model.Image uploadedImage,
    FormFieldState fieldState,
  ) {
    setState(() {
      images = images.map((model.Image imageState) {
        if (uploadedImage.tag == imageState.tag) {
          return uploadedImage;
        }
        return imageState;
      }).toList();
    });

    //update field
    fieldState.didChange(
      (fieldState.value as List)..add(uploadedImage.fileName),
    );
  }

  Future<bool> _onImageDeleted(
    int index,
    model.Image deletedImage,
    FormFieldState fieldState,
  ) {
    Completer completer = Completer<bool>();

    showDialog(
      context: context,
      builder: (context) {
        return ConfirmDialog(
          content: Text('Do you want to delete this image?'),
          onCancelPressed: () {
            completer.complete(false);
          },
          onConfirmPressed: () {
            //remove from local store
            setState(() {
              images = List<model.Image>.from(images)..removeAt(index);
            });

            //remove from form
            if (deletedImage.fileName != null) {
              fieldState.didChange(
                (fieldState.value as List)..remove(deletedImage.fileName),
              );
            }

            completer.complete(true);
          },
        );
      },
    );

    return completer.future;
  }
}
