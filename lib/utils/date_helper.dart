import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DateHelper {
  DateTime dateTime;

  DateHelper({@required this.dateTime});

  DateHelper.fromString({@required String dateTime})
      : dateTime = DateTime.parse(dateTime);

  @override
  String toString() {
    if (dateTime == null) {
      return null;
    }

    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }
}

class DateTimeConverter implements JsonConverter<DateHelper, String> {
  const DateTimeConverter();

  @override
  DateHelper fromJson(String json) {
    return DateHelper.fromString(dateTime: json);
  }

  @override
  String toJson(DateHelper object) {
    return object?.toString();
  }
}
