// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_error.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension GeneralErrorCopyWithExtension on GeneralError {
  GeneralError copyWith({
    String message,
    int statusCode,
  }) {
    return GeneralError(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralError _$GeneralErrorFromJson(Map<String, dynamic> json) {
  return GeneralError(
    message: json['message'] as String,
    statusCode: json['statusCode'] as int,
  );
}

Map<String, dynamic> _$GeneralErrorToJson(GeneralError instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('statusCode', instance.statusCode);
  return val;
}
