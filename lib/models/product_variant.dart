import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_variant.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false, explicitToJson:true)
@DateTimeConverter()
class ProductVariant extends Equatable {
  final int id;
  final String name;
  final String price;
  final int stock;
  @JsonKey(name: 'created_at')
  final DateHelper createdAt;
  @JsonKey(name: 'updated_at')
  final DateHelper updatedAt;

  ProductVariant({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantToJson(this);

  ProductVariant clone() => ProductVariant.fromJson(toJson());

  @override
  List<Object> get props => [id, name, price, stock, createdAt, updatedAt];

  @override
  String toString() => '$runtimeType ' + jsonEncode(this.toJson());
}
