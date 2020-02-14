import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/screens/academic_list_screen.dart';

class AcademicScreen extends StatelessWidget {
  final String idDocument;
  AcademicScreen(this.idDocument);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Acadêmico")),
      body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("home")
              .document(idDocument)
              .collection("subcategorias")
              .orderBy("pos")
              .getDocuments(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Container(
                  height: double.maxFinite,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                );
              default:
                List<DocumentSnapshot> documents =
                    snapshot.data.documents.toList();
                return ListView(
                  children: <Widget>[
                    itemSubCategoria(
                        context,
                        "images/fundo1.jpg",
                        documents[0].data["subcategoria"],
                        Icons.book,
                        documents[0].documentID,
                        "bibliotecas"),
                    itemSubCategoria(
                        context,
                        "images/fundo2.jpg",
                        documents[1].data["subcategoria"],
                        Icons.school,
                        documents[1].documentID,
                        "CAs e DAs"),
                    itemSubCategoria(
                        context,
                        "images/fundo3.jpg",
                        documents[2].data["subcategoria"],
                        Icons.slideshow,
                        documents[2].documentID,
                        "Auditórios"),
                    itemSubCategoria(
                        context,
                        "images/fundo4.jpg",
                        documents[3].data["subcategoria"],
                        Icons.phone,
                        documents[3].documentID,
                        "Secretarias"),
                    itemSubCategoria(
                        context,
                        "images/fundo5.jpg",
                        documents[4].data["subcategoria"],
                        Icons.color_lens,
                        documents[4].documentID,
                        "Museus"),
                  ],
                );
            }
          }),
    );
  }

  Widget itemSubCategoria(
      BuildContext context,
      String image,
      String subcategoria,
      IconData icon,
      String idDomentsub,
      String colectioss) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AcademicListScreen(
                    idDocument, subcategoria, idDomentsub, colectioss)));
      },
      child: Stack(children: <Widget>[
        Container(
          color: Colors.white,
          height: 150.0,
          child: new Image.asset(
            image,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.only(left: 40.0),
          child: Row(children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              width: 32.0,
            ),
            Text(subcategoria,
                style: TextStyle(color: Colors.white, fontSize: 25.0)),
          ]),
        )
      ]),
    );
  }
}
