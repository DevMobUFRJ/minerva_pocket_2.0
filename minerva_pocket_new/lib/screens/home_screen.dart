import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/screens/about_screen.dart';
import 'package:minerva_pocket_new/screens/contact_screen.dart';
import 'package:minerva_pocket_new/tabs/home_tab.dart';
import 'package:minerva_pocket_new/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final  _pageController = PageController (initialPage: 0);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  /*@override
  initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    /* setState(() {
      Navigator.removeRoute(
          context, new MaterialPageRoute(builder: (__) => new Splash()));
    });*/
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }*/

  bool onWillPop() {
    if (_pageController.page.round() == _pageController.initialPage) {
      print("aqui");
      return true;
    } else {
      _pageController.jumpToPage(0);
      print("aqui3");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: PageView(
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
            ContactScreen(),
            AboutScreen(),
          ],
        ),
        onWillPop: () => Future.sync(onWillPop));
    /*return PageView(
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
        AboutScreen(),
      ],
    );*/
  }
}
