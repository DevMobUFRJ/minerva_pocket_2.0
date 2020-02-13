import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minerva Pocket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff00a550),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

