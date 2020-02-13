import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/tabs/home_tab.dart';
import 'package:minerva_pocket_new/widgets/custom_drawer.dart';
class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Container(
          color: Colors.black
        ),
        Container(
          color: Colors.red,
        ),
      ],
    );
  }
}