import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/tiles/custom_drawer.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;
  CustomDrawer(this.pageController);
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff00a550),
              Colors.white,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        );
    return Drawer(
      child: Stack(children: <Widget>[
        _buildDrawerBack(),
        ListView(children: <Widget>[
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.fromLTRB(0.0, 12.0, 16.0, 42.0),
            height: 190.0,
            child: new Image.asset(
              'images/minerva.png',
              height: 30.0,
              fit: BoxFit.contain,
            ),
          ),
          Divider(
            color: Colors.transparent,
          ),
          Container(
            padding: EdgeInsets.only(left: 11.0),
            child: Text(
              "Quem Somos",
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Colors.transparent,
          ),
          DrawerTile(Icons.email, "Contato", pageController, 1),
          DrawerTile(Icons.person, "Sobre", pageController, 2),
          Divider(
            color: Colors.transparent,
          ),
          Container(
            padding: EdgeInsets.only(left: 11.0),
            child: Text(
              "Avalie",
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Colors.transparent,
          ),
          DrawerTile(Icons.rate_review, "Google Play", pageController, 3),
          Divider(
            color: Colors.transparent,
          ),
          Container(
            padding: EdgeInsets.only(left: 11.0),
            child: Text(
              "Contribua",
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Colors.transparent,
          ),
          DrawerTile(Icons.lightbulb_outline, "Como podemos melhorar?", pageController, 4),
        ]),
      ]),
    );
  }
}
