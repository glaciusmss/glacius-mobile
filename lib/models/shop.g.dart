// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ShopCopyWithExtension on Shop {
  Shop copyWith({
    DateHelper createdAt,
    String description,
    int id,
    String name,
    DateHelper updatedAt,
  }) {
    return Shop(
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      id: id ?? this.id,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return Shop(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    createdAt: const DateTimeConverter().fromJson(json['created_at'] as String),
    updatedAt: const DateTimeConverter().fromJson(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$ShopToJson(Shop instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull(
      'created_at', const DateTimeConverter().toJson(instance.createdAt));
  writeNotNull(
      'updated_at', const DateTimeConverter().toJson(instance.updatedAt));
  return val;
}
