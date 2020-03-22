import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/screens/home_screen.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Contato"),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            }),
      ),
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
