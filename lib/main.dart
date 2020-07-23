import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(EnergyChargedTimerApp());

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

class Goal {
  final String name;
  int _elapsedMilliseconds;

  Goal(this.name) {
  }
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  List<Goal> _goals = [
    Goal("국어"),
    Goal("영어"),
    Goal("수학"),
    Goal("플러터"),
    Goal("C 언어로 웹서버 만들기"),
  ];

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
                child: ListView.builder(
                  itemCount: _goals.length,
                  itemBuilder: (context, i) =>
                    Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 20),
                          Icon(Icons.play_circle_filled),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(_goals[i].name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text("00:00:00"),
                          SizedBox(width: 10),
                          PopupMenuButton<TestEnum>(
                            itemBuilder: (context) => [
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
                    ),
                )
              ),
          ),
        ),
      ],
    );
  }
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
    return Container(
      child: Center(
        child: Text("플래너"),
      ),
    );
  }
}
