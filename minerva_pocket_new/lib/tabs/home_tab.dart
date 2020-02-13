import 'package:flutter/material.dart';

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
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Minerva Pocket"),
              ),
              elevation: 0.0,
            ),
          ],
        ),
      ],
    );
  }
}
