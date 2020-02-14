import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/screens/food_screen.dart';
import 'package:minerva_pocket_new/screens/services_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future:
            Firestore.instance.collection("home").orderBy("pos").getDocuments(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              List<DocumentSnapshot> documents =
                  snapshot.data.documents.toList();
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (documents[index].data["categoria"].toString() ==
                            "Serviços") {
                          print(documents[index].documentID);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ServicesScreen(
                                      documents[index].documentID)));
                        } else if (documents[index]
                                .data["categoria"]
                                .toString() ==
                            "Alimentação") {
                          print(documents[index].documentID);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodScreen(
                                      documents[index].documentID)));
                        }
                      },
                      child: Stack(
                        children: <Widget>[
                          //Image.network(documents[index].data["image"]),
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: documents[index].data["image"],
                            fit: BoxFit.cover,
                          ),
                          
                          Container(
                            padding: EdgeInsets.only(top: 135.0, left: 10.0),
                            child: Text(
                              documents[index].data["categoria"],
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
          }
        });
  }
}
