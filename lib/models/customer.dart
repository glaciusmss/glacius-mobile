import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:glacius_mobile/utils/utils.dart';

import 'models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false, explicitToJson: true)
@DateTimeConverter()
class Customer extends Equatable {
  final int id;
  final Marketplace marketplace;
  @JsonKey(name: 'created_at')
  final DateHelper createdAt;
  @JsonKey(name: 'updated_at')
  final DateHelper updatedAt;

  Customer({
    this.id,
    this.marketplace,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  Customer clone() => Customer.fromJson(toJson());

  @override
  List<Object> get props => [id, marketplace, createdAt, updatedAt];

  @override
  String toString() => '$runtimeType ' + jsonEncode(this.toJson());
}
