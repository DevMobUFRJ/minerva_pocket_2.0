import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/screens/food_screen_view.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodScreen extends StatefulWidget {
  final String idDocument;
  FoodScreen(this.idDocument);
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
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
      appBar: AppBar(title: Text("Alimentação")),
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
                    .collection("restaurantes")
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
                                    documents[index].data["tipo"],
                                    documents[index].data["Preços"],
                                    documents[index].data["Pagamento"],
                                    documents[index].data["Localização"],
                                  )
                                : documents[index].data["nome"].contains(filter)
                                    ? cardFood(
                                        documents[index].data["nome"],
                                        documents[index].data["image"],
                                        documents[index].data["tipo"],
                                        documents[index].data["Preços"],
                                        documents[index].data["Pagamento"],
                                        documents[index].data["Localização"],
                                      )
                                    : new Container();
                          });
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget cardFood(String nome, String image, String tipo, String preco,
      String pagamento, String localizao) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodScreenView(
                    nome, image, tipo, preco, pagamento, localizao)));
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
