import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hackocracy/components/roundedButton.dart';
import 'package:hackocracy/screens/awarenessPage.dart';


class MainScreen extends StatefulWidget {
  final String email;
  final int points;
  MainScreen(this.email, this.points);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String emaile;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.email);
    print(widget.points);
    return Scaffold(
        backgroundColor: Color(0xFF013220),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 50.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Text('GREEN',
                      style: TextStyle(
                          fontFamily: 'SyneMono',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0)),
                  SizedBox(width: 10.0),
                  Text('Eye',
                      style: TextStyle(
                          fontFamily: 'SyneMono',
                          color: Colors.white,
                          fontSize: 25.0))
                ],
              ),
            ),
            SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'User: ',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        widget.email ?? 'Current User',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
                height: 30.0),
            Padding(
              padding: const EdgeInsets.only(right: 7.0),
              child: Container(
                height: MediaQuery.of(context).size.height - 185.0,
                decoration: BoxDecoration(
                  color: Color(0xFF049560),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(75.0)),
                ),
                child: ListView(children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 220.0,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(75.0),
                                    bottomLeft: Radius.circular(75.0)),
                              ),
                              margin: EdgeInsets.all(11.0),
                              color: Color(0xFF013220),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Text("Your User Points",
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 25.0)),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(widget.points ?? '100',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30.0)),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text("Your Rating",
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 25.0)),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text("3.5",
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30.0)),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        RoundedButton(
                          title: 'Statistics',
                          colur: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AwarenessPage();
                            }));
                          },
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ));
  }
}
