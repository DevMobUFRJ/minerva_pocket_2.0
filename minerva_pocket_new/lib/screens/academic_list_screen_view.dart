import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AcademicListScreenView extends StatelessWidget {
  final String idSubcategoria;
  final DocumentSnapshot document;
  AcademicListScreenView(this.idSubcategoria, this.document);
  @override
  Widget build(BuildContext context) {
    print(idSubcategoria);
    print(document.data);
    return Scaffold(
        backgroundColor: Colors.white, body: widgetScreenView(context));
  }
  //Verifica a categoria do "Acadêmico" e decide a tela, por enquanto existe apenas a tela de bibliotecas
  widgetScreenView(BuildContext context) {
    if (idSubcategoria == "bibliotecas")
      return academicBibliotecaScreenView(context);
  }

  Widget academicBibliotecaScreenView(BuildContext context) {
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            //Image.network(documents[index].data["image"]),
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: document.data["image"],
              fit: BoxFit.cover,
            ),
            IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 41.0),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Container(
              padding: EdgeInsets.only(top: 155.0, left: 10.0),
              child: Text(
                document.data["nome"],
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text(
                  document.data["centro"],
                  style: TextStyle(fontSize: 17.0, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text(
                  document.data["funcionamento"],
                  style: TextStyle(fontSize: 17.0, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text(
                  document.data["localização"],
                  style: TextStyle(fontSize: 17.0, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text(
                  "Localização",
                  style: TextStyle(fontSize: 17.0, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
