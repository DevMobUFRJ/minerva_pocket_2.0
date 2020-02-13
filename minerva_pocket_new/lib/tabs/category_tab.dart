import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/screens/services_screen.dart';

class CategoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            Firestore.instance.collection("home").orderBy("pos").snapshots(),
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
                                  builder: (context) => ServicesScreen(documents[index].documentID)));
                        }
                      },
                      child: Stack(
                        children: <Widget>[
                          Image.network(documents[index].data["image"]),
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
