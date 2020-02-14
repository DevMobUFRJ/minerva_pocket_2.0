import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  final String idDocument;
  ServicesScreen(this.idDocument);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Serviços")),
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
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
              default:
                List<DocumentSnapshot> documents =
                    snapshot.data.documents.toList();
                return ListView(
                  children: <Widget>[
                    itemSubCategoria("images/fundo1.jpg",
                        documents[0].data["subcategoria"], Icons.print),
                    itemSubCategoria(
                        "images/fundo2.jpg",
                        documents[1].data["subcategoria"],
                        Icons.monetization_on),
                    itemSubCategoria("images/fundo3.jpg",
                        documents[2].data["subcategoria"], Icons.shopping_cart),
                    itemSubCategoria(
                        "images/fundo4.jpg",
                        documents[3].data["subcategoria"],
                        Icons.open_in_browser),
                  ],
                );
            }
          }),
    );
  }

  Widget itemSubCategoria(String image, String subcategoria, IconData icon,
      {String idDoment}) {
    return GestureDetector(
      onTap: () {},
      child: Stack(children: <Widget>[
        Container(
          color: Colors.white,
          height: 150.0,
          child: new Image.asset(
            image,
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
