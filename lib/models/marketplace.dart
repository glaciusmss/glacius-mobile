import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'marketplace.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false, explicitToJson:true)
@DateTimeConverter()
class Marketplace extends Equatable {
  final int id;
  final String name;
  final String website;
  @JsonKey(name: 'created_at')
  final DateHelper createdAt;
  @JsonKey(name: 'updated_at')
  final DateHelper updatedAt;

  Marketplace({
    this.id,
    this.name,
    this.website,
    this.createdAt,
    this.updatedAt,
  });

  factory Marketplace.fromJson(Map<String, dynamic> json) =>
      _$MarketplaceFromJson(json);

  Map<String, dynamic> toJson() => _$MarketplaceToJson(this);

  Marketplace clone() => Marketplace.fromJson(toJson());

  @override
  List<Object> get props => [id, name, website, createdAt, updatedAt];

  @override
  String toString() => '$runtimeType ' + jsonEncode(this.toJson());
}
