import 'dart:convert';
import 'dart:io';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false, explicitToJson: true)
@DateTimeConverter()
class Image extends Equatable {
  final String url;
  final String name;
  @JsonKey(name: 'file_name')
  final String fileName;
  final String collection;
  @JsonKey(ignore: true)
  final PickedFile tempImage; //for temp img to be upload
  @JsonKey(ignore: true)
  final String tag; //uuid for hero widget

  Image({
    this.url,
    this.name,
    this.fileName,
    this.collection,
    this.tempImage,
    this.tag,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);

  Image clone() => Image.fromJson(toJson());

  @override
  List<Object> get props => [url, name, fileName, collection];

  @override
  String toString() => '$runtimeType ' + jsonEncode(this.toJson());
}
