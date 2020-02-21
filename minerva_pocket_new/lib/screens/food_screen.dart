import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/screens/food_screen_view.dart';
import 'package:transparent_image/transparent_image.dart';

//Tela que mostra a lista de restaurantes
//Possui um TextField de pesquisa que precisa ser melhorado
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
                          GeoPoint geoPoint = documents[0].data["localizacao"];
                          print(geoPoint.latitude);
                      return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            return filter == null || filter == ""
                                ? cardFood(
                                    documents[index].data["nome"],
                                    documents[index].data["image"],
                                    documents[index].data["tipo"],
                                    documents[index].data["preco"],
                                    documents[index].data["pagamento"],
                                    documents[index].data["funcionamento"],
                                    documents[index].data["localizacao"],
                                    )
                                : documents[index].data["nome"].contains(filter)
                                    ? cardFood(
                                        documents[index].data["nome"],
                                        documents[index].data["image"],
                                        documents[index].data["tipo"],
                                        documents[index].data["preco"],
                                        documents[index].data["pagamento"],
                                        documents[index].data["funcionamento"],
                                        documents[index].data["localizacao"],
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
      String pagamento, String funcionamento,
      GeoPoint localizacao) {
    return GestureDetector(
      onTap: () {
        //Ao clicar em um restaurante da lista, abre a FoodScreenView que recebe vários paramêtros
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodScreenView(
                    nome, image, tipo, preco, pagamento, funcionamento,
                    localizacao,)));
      },
      child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          width: double.maxFinite,
          child: Column(children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        nome,
                        style: TextStyle(fontSize: 17.0, color: Colors.black),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FadeInImage.memoryNetwork(
                        width: 80,
                        height: 50.0,
                        placeholder: kTransparentImage,
                        image: image,
                        fit: BoxFit.cover,
                      ),
                    ]),
              ],
            ),
            Divider(),
          ])),
      /*child: Container(
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
      ),*/
    );
  }
}
