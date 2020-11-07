import 'package:flutter/material.dart';

// constant Decorated textfield for user input

const constant_textfield = InputDecoration(
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  hintText: 'Enter Data',
  hintStyle: TextStyle(color: Colors.white), 
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
);
