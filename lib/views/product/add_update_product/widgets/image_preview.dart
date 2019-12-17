import 'package:flutter/material.dart';
import 'package:glacius_mobile/models/models.dart' as model;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePreview extends StatefulWidget {
  final List<model.Image> images;
  final int initialIndex;
  final PageController pageController;
  final Function(int index, model.Image deletedImage) onImageDelete;

  ImagePreview({
    @required this.images,
    @required this.initialIndex,
    @required this.onImageDelete,
  }) : pageController = PageController(initialPage: initialIndex);

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String selectedMenuItem) async {
              if (selectedMenuItem == 'delete') {
                bool isDeleted = await widget.onImageDelete(
                  currentIndex,
                  widget.images[currentIndex],
                );

                if (isDeleted) {
                  Navigator.of(context).pop();
                }
              }
            },
            itemBuilder: (context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                  ),
                )
              ];
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PhotoViewGallery.builder(
              itemCount: widget.images.length,
              pageController: widget.pageController,
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),
              onPageChanged: _onPageChanged,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: widget.images[index].url == null
                      ? FileImage(widget.images[index].tempImage)
                      : NetworkImage(widget.images[index].url),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 1.1,
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: widget.images[index].tag,
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildBulletIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> _buildBulletIndicator() {
    List<Widget> indicatorWidget = [];

    widget.images.asMap().forEach((int index, _) {
      indicatorWidget.addAll(<Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (currentIndex == index) ? Colors.white : Colors.grey,
          ),
        ),
        SizedBox(width: 5.0),
      ]);
    });

    return indicatorWidget;
  }
}
