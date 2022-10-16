import 'package:flutter/material.dart';
import 'package:quotes_app/screens/Like.dart';
import 'package:quotes_app/screens/allquotes.dart';
import 'package:quotes_app/screens/homescreen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      'AllQuotes': (context) => AllQuotes(),
      'AllLike': (context) => AllLike(),
    },
  ));
}
