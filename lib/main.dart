import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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

class StatisticsScreenWidget extends StatefulWidget {
  @override
  _StatisticsScreenWidgetState createState() => _StatisticsScreenWidgetState();
}

class _StatisticsScreenWidgetState extends State<StatisticsScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("통계"),
      ),
    );
  }
}

class PlannerScreenWidget extends StatefulWidget {
  @override
  _PlannerScreenWidgetState createState() => _PlannerScreenWidgetState();
}

class _PlannerScreenWidgetState extends State<PlannerScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          child: DefaultTextStyle(
            style: DefaultTextStyle.of(context).style.apply(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("00:00:00"),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_left),
                      color: Colors.white,
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("어제로 가기 버튼 누름"))
                        );
                      },
                    ),
                    Text("2020. 7. 23."),
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      color: Colors.white,
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("내일로 가기 버튼 누름"))
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 6,
          child: Container(
            color: Colors.black12,
          ),
        ),
        Row(
          children: [
            FlatButton(
              child: Text("오늘의 한마디"),
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("오늘의 한마디 버튼 누름"))
                );
              },
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  FlatButton(
                    child: Text("D-day"),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.3,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text("0.0"),
                      SizedBox(width: 4),
                    ],
                  ),
                ],
              ),
            ),
          ]
        ),
        SizedBox(
          height: 6,
          child: Container(
            color: Colors.black12,
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 36,
                              color: Colors.red,
                              child: Text(""),
                            ),
                            SizedBox(width: 8),
                            Text("국어", textScaleFactor: 1.2,),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 16),
                            Text(
                              "00:01:13",
                              style: TextStyle(color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 36,
                              color: Colors.green,
                              child: Text(""),
                            ),
                            SizedBox(width: 8),
                            Text("영어", textScaleFactor: 1.2,),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 16),
                            Text(
                              "00:01:13",
                              style: TextStyle(color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text("5시"),
                      Container(
                        width: 1,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 30, height: 30),
                      SizedBox(
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ]
    );
  }
}
