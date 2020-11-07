import 'package:flutter/material.dart';

//Rounded Button Widget to use in any screen

class RoundedButton extends StatelessWidget {
  RoundedButton({this.colur, this.title, this.onPressed});
  final Color colur;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colur,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed
          ,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          textColor: Colors.white,
        ),
      ),
    );
  }
}
