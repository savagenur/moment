import 'package:intl/intl.dart';

class DateTimeConverter {
  static String toText(DateTime date) {
    return DateFormat("MM.dd.yyyy").format(date);
  }

  static String toTextTimeAndDate(DateTime date) {
    final hour = "${date.hour}".padLeft(2, "0");
    final minute = "${date.minute}".padLeft(2, "0");
    final dateText = DateFormat("MM.dd.yyyy").format(date);
    final timeText = "$hour:$minute";
    return "$timeText - $dateText";
  }
}
