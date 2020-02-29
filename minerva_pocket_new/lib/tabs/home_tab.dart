import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/tabs/category_tab.dart';
import 'package:minerva_pocket_new/tabs/total_location_tab.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff00a550),
              Colors.white,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        );
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Color(0xff00a550),
            appBar: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  text: "Categorias",
                ),
                Tab(text: "Navegar"),
              ],
            ),
            body: TabBarView(
              children: [
                CategoryTab(),
                TotalLocationTab(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
