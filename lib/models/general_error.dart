import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'general_error.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false, explicitToJson: true)
@DateTimeConverter()
class GeneralError extends Equatable {
  final String message;
  final int statusCode;

  GeneralError({
    this.message,
    this.statusCode,
  });

  factory GeneralError.fromJson(Map<String, dynamic> json) =>
      _$GeneralErrorFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralErrorToJson(this);

  GeneralError clone() => GeneralError.fromJson(toJson());

  @override
  List<Object> get props => [message, statusCode];

  @override
  String toString() => '$runtimeType ' + jsonEncode(this.toJson());
}
