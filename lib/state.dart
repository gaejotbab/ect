import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Goal {
  final String name;
  final Color color;

  Map<LocalDate, DailyGoalRecord> dailyGoalRecords;

  Stopwatch stopwatch = Stopwatch();

  Goal(this.name, this.color);
}

class LocalDate implements Comparable {
  final int year;
  final int month;
  final int day;

  LocalDate(this.year, this.month, this.day);

  static LocalDate today() {
    var now = DateTime.now();
    return LocalDate(now.year, now.month, now.day);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalDate &&
          runtimeType == other.runtimeType &&
          year == other.year &&
          month == other.month &&
          day == other.day;

  @override
  int get hashCode => year.hashCode ^ month.hashCode ^ day.hashCode;

  @override
  int compareTo(other) {
    var yearComparison = this.year.compareTo(other.year);
    if (yearComparison != 0) {
      return yearComparison;
    }

    var monthComparison = this.month.compareTo(other.month);
    if (monthComparison != 0) {
      return monthComparison;
    }

    return this.day.compareTo(other.day);
  }
}

class DailyGoalRecord {
  Map<int, int> achievements;
  int totalTime;
}

class AppState extends ChangeNotifier {
  final List<Goal> goals = [
    Goal("국어", Colors.red),
    Goal("수학", Colors.purple),
    Goal("영어", Colors.cyan),
    Goal("개발", Colors.black26),
  ];

  Map<LocalDate, int> dailyAllGoalsTime;
}
