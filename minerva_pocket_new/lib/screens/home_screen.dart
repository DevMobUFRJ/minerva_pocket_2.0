import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/tabs/home_tab.dart';
import 'package:minerva_pocket_new/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          key: _scaffoldKey,
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          appBar: new AppBar(
            title: Text("Minerva Pocket"),
            leading: new IconButton(
                icon: new Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState.openDrawer()),
          ),
        ),
      ],
    );
  }
}
