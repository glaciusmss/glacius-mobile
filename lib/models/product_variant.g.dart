// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ProductVariantCopyWithExtension on ProductVariant {
  ProductVariant copyWith({
    DateHelper createdAt,
    int id,
    String name,
    String price,
    int stock,
    DateHelper updatedAt,
  }) {
    return ProductVariant(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariant _$ProductVariantFromJson(Map<String, dynamic> json) {
  return ProductVariant(
    id: json['id'] as int,
    name: json['name'] as String,
    price: json['price'] as String,
    stock: json['stock'] as int,
    createdAt: const DateTimeConverter().fromJson(json['created_at'] as String),
    updatedAt: const DateTimeConverter().fromJson(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$ProductVariantToJson(ProductVariant instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('price', instance.price);
  writeNotNull('stock', instance.stock);
  writeNotNull(
      'created_at', const DateTimeConverter().toJson(instance.createdAt));
  writeNotNull(
      'updated_at', const DateTimeConverter().toJson(instance.updatedAt));
  return val;
}
