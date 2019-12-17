import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_channel.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false, explicitToJson:true)
@DateTimeConverter()
class NotificationChannel extends Equatable {
  final int id;
  final String name;
  final String website;
  @JsonKey(name: 'created_at')
  final DateHelper createdAt;
  @JsonKey(name: 'updated_at')
  final DateHelper updatedAt;

  NotificationChannel({
    this.id,
    this.name,
    this.website,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationChannel.fromJson(Map<String, dynamic> json) =>
      _$NotificationChannelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationChannelToJson(this);

  NotificationChannel clone() => NotificationChannel.fromJson(toJson());

  @override
  List<Object> get props => [id, name, website, createdAt, updatedAt];

  @override
  String toString() => '$runtimeType ' + jsonEncode(this.toJson());
}
