import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
