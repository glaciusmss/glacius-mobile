// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ProductCopyWithExtension on Product {
  Product copyWith({
    DateHelper createdAt,
    String description,
    int id,
    List images,
    String name,
    List productVariants,
    DateHelper updatedAt,
  }) {
    return Product(
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      id: id ?? this.id,
      images: images ?? this.images,
      name: name ?? this.name,
      productVariants: productVariants ?? this.productVariants,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
    productVariants: (json['product_variants'] as List)
        ?.map((e) => e == null
            ? null
            : ProductVariant.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    createdAt: const DateTimeConverter().fromJson(json['created_at'] as String),
    updatedAt: const DateTimeConverter().fromJson(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('images', instance.images);
  writeNotNull('product_variants',
      instance.productVariants?.map((e) => e?.toJson())?.toList());
  writeNotNull(
      'created_at', const DateTimeConverter().toJson(instance.createdAt));
  writeNotNull(
      'updated_at', const DateTimeConverter().toJson(instance.updatedAt));
  return val;
}
