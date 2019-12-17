// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension CustomerCopyWithExtension on Customer {
  Customer copyWith({
    DateHelper createdAt,
    int id,
    Marketplace marketplace,
    DateHelper updatedAt,
  }) {
    return Customer(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      marketplace: marketplace ?? this.marketplace,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    id: json['id'] as int,
    marketplace: json['marketplace'] == null
        ? null
        : Marketplace.fromJson(json['marketplace'] as Map<String, dynamic>),
    createdAt: const DateTimeConverter().fromJson(json['created_at'] as String),
    updatedAt: const DateTimeConverter().fromJson(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('marketplace', instance.marketplace?.toJson());
  writeNotNull(
      'created_at', const DateTimeConverter().toJson(instance.createdAt));
  writeNotNull(
      'updated_at', const DateTimeConverter().toJson(instance.updatedAt));
  return val;
}
