// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ImageCopyWithExtension on Image {
  Image copyWith({
    String collection,
    String fileName,
    String name,
    String tag,
    File tempImage,
    String url,
  }) {
    return Image(
      collection: collection ?? this.collection,
      fileName: fileName ?? this.fileName,
      name: name ?? this.name,
      tag: tag ?? this.tag,
      tempImage: tempImage ?? this.tempImage,
      url: url ?? this.url,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image(
    url: json['url'] as String,
    name: json['name'] as String,
    fileName: json['file_name'] as String,
    collection: json['collection'] as String,
  );
}

Map<String, dynamic> _$ImageToJson(Image instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  writeNotNull('name', instance.name);
  writeNotNull('file_name', instance.fileName);
  writeNotNull('collection', instance.collection);
  return val;
}
