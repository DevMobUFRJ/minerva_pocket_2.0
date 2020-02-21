import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minerva_pocket_new/screens/acedemic_screen.dart';
import 'package:minerva_pocket_new/screens/food_screen.dart';
import 'package:minerva_pocket_new/screens/services_screen.dart';
import 'package:transparent_image/transparent_image.dart';

//Tela Inicial Do Aplicativo basicamente, onde se encontram as principais categorias
//Future - Primeiros pegamos dos dados do Firebase, depois a tela vai sendo desenhada
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
              //Indicador de Progresso
              return Container(
                height: 200.0,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              );
            default:
              List<DocumentSnapshot> documents =
                  snapshot.data.documents.toList();
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      //A tela que aparece depende da categoria do firebase
                      //Ex: Se a categoria for Serviços vai pra tela de Serviços
                      //Cada tela possui um construtor que recebe o ID do documento do firebase para facilitar o caminho de pesquisa
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
                                  builder: (context) =>
                                      FoodScreen(documents[index].documentID)));
                        } else if (documents[index]
                                .data["categoria"]
                                .toString() ==
                            "Acadêmico") {
                          print(documents[index].documentID);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AcademicScreen(
                                      documents[index].documentID)));
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          FadeInImage.memoryNetwork(
                            width: double.maxFinite,
                            placeholder: kTransparentImage,
                            image: documents[index].data["image"],
                            fit: BoxFit.cover,
                          ),
                          Container(
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
