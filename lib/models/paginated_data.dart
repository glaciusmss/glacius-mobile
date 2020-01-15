import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:glacius_mobile/utils/utils.dart';

import 'package:json_annotation/json_annotation.dart';

part 'paginated_data.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false, explicitToJson: true)
@DateTimeConverter()
class PaginatedData extends Equatable {
  final dynamic data;
  final Map<String, dynamic> links;
  final Map<String, dynamic> meta;

  const PaginatedData({
    this.data,
    this.links,
    this.meta,
  });

  factory PaginatedData.fromJson(Map<String, dynamic> json) =>
      _$PaginatedDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedDataToJson(this);

  PaginatedData clone() => PaginatedData.fromJson(toJson());

  @override
  List<Object> get props => [
        data,
        links,
        meta,
      ];

  @override
  String toString() => '$runtimeType ' + jsonEncode(this.toJson());
}
