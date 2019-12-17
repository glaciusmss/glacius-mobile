// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension OrderCopyWithExtension on Order {
  Order copyWith({
    DateHelper createdAt,
    int id,
    Marketplace marketplace,
    String subtotalPrice,
    String totalPrice,
    DateHelper updatedAt,
  }) {
    return Order(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      marketplace: marketplace ?? this.marketplace,
      subtotalPrice: subtotalPrice ?? this.subtotalPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['id'] as int,
    totalPrice: json['total_price'] as String,
    subtotalPrice: json['subtotal_price'] as String,
    marketplace: json['marketplace'] == null
        ? null
        : Marketplace.fromJson(json['marketplace'] as Map<String, dynamic>),
    createdAt: const DateTimeConverter().fromJson(json['created_at'] as String),
    updatedAt: const DateTimeConverter().fromJson(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('total_price', instance.totalPrice);
  writeNotNull('subtotal_price', instance.subtotalPrice);
  writeNotNull('marketplace', instance.marketplace?.toJson());
  writeNotNull(
      'created_at', const DateTimeConverter().toJson(instance.createdAt));
  writeNotNull(
      'updated_at', const DateTimeConverter().toJson(instance.updatedAt));
  return val;
}
