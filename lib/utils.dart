import 'package:intl/intl.dart';

String formatMilliseconds(int milliseconds) {
  var formatter = NumberFormat("00");

  var seconds = milliseconds ~/ 1000 % 60;
  var minutes = milliseconds ~/ 1000 ~/ 60 % 60;
  var hours = milliseconds ~/ 1000 ~/ 60 ~/ 60;

  return formatter.format(hours) +
      ":" +
      formatter.format(minutes) +
      ":" +
      formatter.format(seconds);
}
