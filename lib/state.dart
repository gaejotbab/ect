import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

class Goal {
  final String name;
  final Color color;

  Map<LocalDate, DailyGoalRecord> dailyGoalRecords;

  Stopwatch stopwatch = Stopwatch();

  Goal(this.name, this.color) {
    dailyGoalRecords = SplayTreeMap<LocalDate, DailyGoalRecord>();
  }

  DailyGoalRecord todayGoalRecord() {
    var today = LocalDate.today();

    var todayGoalRecord = dailyGoalRecords[today];
    if (todayGoalRecord == null) {
      todayGoalRecord = DailyGoalRecord();
      dailyGoalRecords[today] = todayGoalRecord;
    }

    return todayGoalRecord;
  }
}

class DailyGoalRecord {
  // Key: 시작 시각, Value: 수행 시간
  Map<int, int> periods = SplayTreeMap<int, int>();
  int totalTime = 0;
}

class AppState extends ChangeNotifier {
  final List<Goal> goals = [
    Goal("국어", Colors.red),
    Goal("수학", Colors.purple),
    Goal("영어", Colors.cyan),
    Goal("개발", Colors.black26),
  ];

  Map<LocalDate, int> dailyAllGoalsTotalTimes = SplayTreeMap<LocalDate, int>();

  int todayAllGoalsTotalTimes() {
    return dailyAllGoalsTotalTimes[LocalDate.today()] ?? 0;
  }

  void addToTodayAllGoalsTotalTimes(int timeMs) {
    var today = LocalDate.today();

    var dailyAllGoalsTotalTime = dailyAllGoalsTotalTimes[today] ?? 0;

    dailyAllGoalsTotalTimes[today] = dailyAllGoalsTotalTime + timeMs;
  }
}
