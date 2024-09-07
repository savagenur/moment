import 'package:flutter/material.dart';

class TimeOfDayConverter {
  static String convertToString(TimeOfDay timeOfDay) {
    final hour = "${timeOfDay.hour}".padLeft(2, "0");
    final minute = "${timeOfDay.minute}".padLeft(2, "0");
    return "$hour:$minute";
  }

  static TimeOfDay convertToTimeOfDay(String time) {
    final _time = time.split(":");
    final hour = int.parse(_time[0]);
    final minute = int.parse(_time[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
