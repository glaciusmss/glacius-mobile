// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension MarketplaceCopyWithExtension on Marketplace {
  Marketplace copyWith({
    DateHelper createdAt,
    int id,
    String name,
    DateHelper updatedAt,
    String website,
  }) {
    return Marketplace(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
      website: website ?? this.website,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Marketplace _$MarketplaceFromJson(Map<String, dynamic> json) {
  return Marketplace(
    id: json['id'] as int,
    name: json['name'] as String,
    website: json['website'] as String,
    createdAt: const DateTimeConverter().fromJson(json['created_at'] as String),
    updatedAt: const DateTimeConverter().fromJson(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$MarketplaceToJson(Marketplace instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('website', instance.website);
  writeNotNull(
      'created_at', const DateTimeConverter().toJson(instance.createdAt));
  writeNotNull(
      'updated_at', const DateTimeConverter().toJson(instance.updatedAt));
  return val;
}
