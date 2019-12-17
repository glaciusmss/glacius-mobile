// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserCopyWithExtension on User {
  User copyWith({
    DateHelper createdAt,
    String email,
    String emailVerifiedAt,
    int id,
    String name,
    DateHelper updatedAt,
  }) {
    return User(
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    emailVerifiedAt: json['email_verified_at'] as String,
    createdAt: const DateTimeConverter().fromJson(json['created_at'] as String),
    updatedAt: const DateTimeConverter().fromJson(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('email_verified_at', instance.emailVerifiedAt);
  writeNotNull(
      'created_at', const DateTimeConverter().toJson(instance.createdAt));
  writeNotNull(
      'updated_at', const DateTimeConverter().toJson(instance.updatedAt));
  return val;
}
