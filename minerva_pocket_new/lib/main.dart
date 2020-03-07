import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/tabs/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minerva Pocket',
      theme: ThemeData(
        //Trocar Depois!!
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff00a550),
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

