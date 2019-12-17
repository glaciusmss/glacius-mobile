import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:glacius_mobile/utils/date_helper.dart';

abstract class BaseModel extends Equatable {
  final int id;
  final DateHelper createdAt;
  final DateHelper updatedAt;

  BaseModel({
    this.id,
    DateTime createdAt,
    DateTime updatedAt,
  })  : createdAt = DateHelper(dateTime: createdAt),
        updatedAt = DateHelper(dateTime: updatedAt);

  BaseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateHelper.fromString(dateTime: json['created_at']),
        updatedAt = DateHelper.fromString(dateTime: json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt.toString(),
        'updated_at': createdAt.toString(),
      };

  @override
  List<Object> get props => [id, createdAt, updatedAt];

  @override
  String toString() => '$runtimeType ' + jsonEncode(this.toJson());
}
