import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Goal {
  final String name;
  final Color color;
  Stopwatch stopwatch = Stopwatch();

  Goal(this.name, this.color) {
  }
}

class AppState extends ChangeNotifier {
  final List<Goal> goals = [
    Goal("국어", Colors.red),
    Goal("수학", Colors.purple),
    Goal("영어", Colors.cyan),
    Goal("개발", Colors.black26),
  ];

  int totalElapsedTime = 0;
}