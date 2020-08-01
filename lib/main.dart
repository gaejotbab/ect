import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'planner.dart';
import 'state.dart';
import 'statistics.dart';

void main() => runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: EnergyChargedTimerApp(),
    )
);

class EnergyChargedTimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Energy Charged Timer',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  int _selectedIndex = 1;

  List<String> _appBarTitleTexts = [
    "플래너",
    "에너지 충전한 타이머",
    "통계",
  ];

  List<Widget> _screenWidgets = [
    PlannerScreenWidget(),
    HomeScreenWidget(),
    StatisticsScreenWidget(),
  ];

  void _onBottomNavigationBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitleTexts[_selectedIndex]),
      ),
      body: _screenWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            title: Text("플래너"),
            icon: Icon(Icons.event_note),
          ),
          BottomNavigationBarItem(
            title: Text("홈"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("통계"),
            icon: Icon(Icons.insert_chart),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orangeAccent,
        onTap: _onBottomNavigationBarTap,
      ),
    );
  }
}

class HomeScreenWidget extends StatefulWidget {
  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

enum TestEnum { a, b }

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  Timer _timer;

  _HomeScreenWidgetState() {
    _timer = new Timer.periodic(new Duration(milliseconds: 10), _onTimer);
  }

  void _onTimer(Timer timer) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          child: DefaultTextStyle(
            style: DefaultTextStyle.of(context).style.apply(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 25),
                Text("2020. 7. 19.", textAlign: TextAlign.center,),
                SizedBox(height: 15),
                Text("00:00:00", textAlign: TextAlign.center, textScaleFactor: 4),
                SizedBox(height: 15),
                Icon(Icons.timer_off, color: Colors.white),
                SizedBox(height: 25),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Text("목표/과목"),
            Text("공부시간"),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        Expanded(
          child: Builder(
            builder: (context) =>
              DefaultTextStyle(
                style: DefaultTextStyle.of(context)
                    .style.apply(fontSizeFactor: 1.5),
                child: Consumer<AppState>(
                  builder: (context, state, child) => ListView.builder(
                    itemCount: state.goals.length,
                    itemBuilder: (context, i) {
                      var goal = state.goals[i];
                      return Container(
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              color: goal.color,
                              icon: Icon(Icons.play_circle_filled),
                              iconSize: 36,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        GoalTimerScreen()
                                    )
                                );
                              },
                            ),
                            Expanded(
                              child: Text(goal.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text("${goal.stopwatch.elapsed
                                .inSeconds}"),
                            SizedBox(width: 10),
                            PopupMenuButton<TestEnum>(
                              itemBuilder: (context) =>
                              [
                                PopupMenuItem<TestEnum>(
                                  value: TestEnum.a,
                                  child: Text("a랜다"),
                                ),
                                PopupMenuItem<TestEnum>(
                                  value: TestEnum.b,
                                  child: Text("b라더라"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                )
              ),
          ),
        ),
      ],
    );
  }
}

class GoalTimerScreen extends StatefulWidget {
  @override
  _GoalTimerScreenState createState() => _GoalTimerScreenState();
}

class _GoalTimerScreenState extends State<GoalTimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Builder(
          builder: (context) => DefaultTextStyle(
            style: DefaultTextStyle.of(context).style.apply(color: Colors.white),
            child: Column(
              children: <Widget>[
                SizedBox(height: 72),
                Text("총 공부시간"),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("00:00:00", textScaleFactor: 4),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.pause_circle_filled),
                      iconSize: 64,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("국어"),
                          SizedBox(height: 4),
                          Text("00:00:00", textScaleFactor: 1.5),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("현재 집중시간"),
                          SizedBox(height: 4),
                          Text("00:00:00", textScaleFactor: 1.5),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
