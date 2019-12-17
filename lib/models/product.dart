import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false, explicitToJson:true)
@DateTimeConverter()
class Product extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<String> images;
  @JsonKey(name: 'product_variants')
  final List<ProductVariant> productVariants;
  @JsonKey(name: 'created_at')
  final DateHelper createdAt;
  @JsonKey(name: 'updated_at')
  final DateHelper updatedAt;

  Product({
    this.id,
    this.name,
    this.description,
    this.images,
    this.productVariants,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product clone() => Product.fromJson(toJson());

  @override
  List<Object> get props => [
        id,
        name,
        description,
        productVariants,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() => '$runtimeType ' + jsonEncode(this.toJson());
}
