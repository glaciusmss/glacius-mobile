// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PaginatedDataCopyWithExtension on PaginatedData {
  PaginatedData copyWith({
    dynamic data,
    Map links,
    Map meta,
  }) {
    return PaginatedData(
      data: data ?? this.data,
      links: links ?? this.links,
      meta: meta ?? this.meta,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedData _$PaginatedDataFromJson(Map<String, dynamic> json) {
  return PaginatedData(
    data: json['data'],
    links: json['links'] as Map<String, dynamic>,
    meta: json['meta'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$PaginatedDataToJson(PaginatedData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  writeNotNull('links', instance.links);
  writeNotNull('meta', instance.meta);
  return val;
}
