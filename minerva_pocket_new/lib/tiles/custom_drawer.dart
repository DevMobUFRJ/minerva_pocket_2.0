import 'package:flutter/material.dart';

//Widget clicável do menu lateral
class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;
  DrawerTile(this.icon, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          //Isso faz o menu fechar quando algum botão é pressionado
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: Container(
          padding: EdgeInsets.only(left: 25.0),
          height: 60.0,
          child: Row(children: <Widget>[
            Icon(icon, size: 32.0, color: Colors.white),
            SizedBox(
              width: 20.0,
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white),
            ),
          ]),
        ),
      ),
    );
  }
}
