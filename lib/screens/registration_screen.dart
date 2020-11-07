import 'package:firebase_database/firebase_database.dart';
import 'package:hackocracy/main.dart';
import 'package:flutter/material.dart';
import 'package:hackocracy/components/constants.dart';
import 'package:hackocracy/components/roundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hackocracy/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showspinner = false;
  String email;
  String password;
  int points=0;
  double ranking=0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF013220),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'REGISTRATION',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SyneMono',
                  color: Colors.white,
                  fontSize: 39.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: constant_textfield.copyWith(hintText: 'ENTER YOUR EMAIL'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration:
                      constant_textfield.copyWith(hintText: 'ENTER YOUR PASSWORD')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'REGISTER',
                colur: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showspinner = true;
                  });
                  try {
                    final newuser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newuser != null) {
                      DatabaseReference ref =
                          FirebaseDatabase.instance.reference();
                      var data = {
                        "email": email,
                        "points": points,
                        "ranking": ranking,
                        "password": password
                      };
                      ref.child("Users").push().set(data);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    }
                    setState(() {
                      showspinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
