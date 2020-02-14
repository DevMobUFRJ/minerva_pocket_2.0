import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/screens/academic_list_screen_view.dart';
import 'package:transparent_image/transparent_image.dart';

class AcademicListScreen extends StatefulWidget {
  final String idDocument;
  final String nome;
  final String idDocumentAcademic;
  final String idCollection;
  AcademicListScreen(
      this.idDocument, this.nome, this.idDocumentAcademic, this.idCollection);
  @override
  _AcademicListScreenState createState() => _AcademicListScreenState();
}

class _AcademicListScreenState extends State<AcademicListScreen> {
  TextEditingController controller = new TextEditingController();
  String filter;
  @override
  initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nome)),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            padding: EdgeInsets.all(10.0),
            color: Color(0xff00a550),
            child: Container(
              color: Colors.white,
              child: TextField(
                decoration: new InputDecoration(labelText: "Pesquisar"),
                controller: controller,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
                future: Firestore.instance
                    .collection("home")
                    .document(widget.idDocument)
                    .collection("subcategorias")
                    .document(widget.idDocumentAcademic)
                    .collection(widget.idCollection)
                    .getDocuments(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      );
                    default:
                      List<DocumentSnapshot> documents =
                          snapshot.data.documents.toList();
                      return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            return filter == null || filter == ""
                                ? cardFood(
                                    documents[index].data["nome"],
                                    documents[index].data["image"],
                                    documents[index])
                                : documents[index].data["nome"].contains(filter)
                                    ? cardFood(
                                        documents[index].data["nome"],
                                        documents[index].data["image"],
                                        documents[index])
                                    : new Container();
                          });
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget cardFood(String nome, String image, DocumentSnapshot document) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AcademicListScreenView(widget.idCollection, document)));
      },
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  nome,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(
              width: 50.0,
            ),
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: image,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}