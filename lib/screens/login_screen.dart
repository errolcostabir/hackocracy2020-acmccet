import 'package:hackocracy/main.dart';
import 'package:flutter/material.dart';
import 'package:hackocracy/components/constants.dart';
//import 'package:hackocracy/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../main.dart';
import 'package:hackocracy/components/roundedButton.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showspinner = false;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

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
                'LOGIN',
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
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration:
                      constant_textfield.copyWith(hintText: 'ENTER YOUR EMAIL')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    password = value;
                  },
                  decoration:
                      constant_textfield.copyWith(hintText: 'ENTER YOUR PASSWORD')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'LOGIN',
                colur: Color(0xFF049560),
                //on pressed function is called to allow user to log in using firebase auth
                onPressed: () async {
                  setState(() {
                    showspinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BottomNavBar(
                          email: email,

                        );
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
