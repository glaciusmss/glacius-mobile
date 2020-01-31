// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserProfileCopyWithExtension on UserProfile {
  UserProfile copyWith({
    DateHelper createdAt,
    String dateOfBirth,
    String gender,
    int id,
    String phoneNumber,
    DateHelper updatedAt,
  }) {
    return UserProfile(
      createdAt: createdAt ?? this.createdAt,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
    id: json['id'] as int,
    phoneNumber: json['phone_number'] as String,
    dateOfBirth: json['date_of_birth'] as String,
    gender: json['gender'] as String,
    createdAt: const DateTimeConverter().fromJson(json['created_at'] as String),
    updatedAt: const DateTimeConverter().fromJson(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('date_of_birth', instance.dateOfBirth);
  writeNotNull('gender', instance.gender);
  writeNotNull(
      'created_at', const DateTimeConverter().toJson(instance.createdAt));
  writeNotNull(
      'updated_at', const DateTimeConverter().toJson(instance.updatedAt));
  return val;
}
