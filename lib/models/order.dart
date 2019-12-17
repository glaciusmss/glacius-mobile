import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:glacius_mobile/utils/utils.dart';

import 'models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false, explicitToJson:true)
@DateTimeConverter()
class Order extends Equatable {
  final int id;
  @JsonKey(name: 'total_price')
  final String totalPrice;
  @JsonKey(name: 'subtotal_price')
  final String subtotalPrice;
  final Marketplace marketplace;
  @JsonKey(name: 'created_at')
  final DateHelper createdAt;
  @JsonKey(name: 'updated_at')
  final DateHelper updatedAt;

  Order({
    this.id,
    this.totalPrice,
    this.subtotalPrice,
    this.marketplace,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order clone() => Order.fromJson(toJson());

  @override
  List<Object> get props => [
        id,
        totalPrice,
        subtotalPrice,
        marketplace,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() => '$runtimeType ' + jsonEncode(this.toJson());
}
