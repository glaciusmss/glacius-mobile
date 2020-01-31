import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false, explicitToJson: true)
@DateTimeConverter()
class UserProfile extends Equatable {
  final int id;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'date_of_birth')
  final String dateOfBirth;
  final String gender;
  @JsonKey(name: 'created_at')
  final DateHelper createdAt;
  @JsonKey(name: 'updated_at')
  final DateHelper updatedAt;

  UserProfile({
    this.id,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  UserProfile clone() => UserProfile.fromJson(toJson());

  @override
  List<Object> get props => [
        id,
        phoneNumber,
        dateOfBirth,
        gender,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() => '$runtimeType ' + jsonEncode(this.toJson());
}
