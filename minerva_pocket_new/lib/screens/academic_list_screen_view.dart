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

  // document.data["centro"]
  //Verifica a categoria do "Acadêmico" e decide a tela, por enquanto existe apenas a tela de bibliotecas
  widgetScreenView(BuildContext context) {
    if (idSubcategoria == "bibliotecas")
      return academicBibliotecaScreenView(context);
    else if (idSubcategoria == "CAs e DAs") {
      return academicCAsDasScreenView(context);
    }
    else if (idSubcategoria == "Auditórios") {
      return academicAuditoriosScreenView(context);
    }
  }

  Widget itemLine(String title, String document) {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            width: double.maxFinite,
            child: Stack(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(fontSize: 17.0, color: Colors.black),
                    ),
                  ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                Text(
                  document,
                  style: TextStyle(fontSize: 17.0, color: Colors.grey),
                ),
              ])
            ])),
        SizedBox(height: 15.0, child: Divider()),
      ],
    );
  }

  Widget academicBibliotecaScreenView(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  //Image.network(documents[index].data["image"]),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: document.data["image"],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                    child: Text(
                      document.data["nome"],
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 41.0),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        itemLine("Centro:", document.data["centro"]),
        itemLine("Funcionamento", document.data["funcionamento"]),
        itemLine("Localização", document.data["localização"]),
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

  Widget academicCAsDasScreenView(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  //Image.network(documents[index].data["image"]),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: document.data["image"],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                    child: Text(
                      document.data["nome"],
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 41.0),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        itemLine("Centro:", document.data["Centro"]),
        itemLine("Funcionamento", document.data["Funcionamento"]),
        itemLine("Contato", document.data["Contato"]),
        itemLine("Observações", document.data["Observações"]),
        itemLine("Localização", document.data["Localização"]),
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
  Widget academicAuditoriosScreenView(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  //Image.network(documents[index].data["image"]),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: document.data["image"],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                    child: Text(
                      document.data["nome"],
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 41.0),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        itemLine("Centro:", document.data["Centro"]),
        verificador(document.data.containsKey("Observações")),
        itemLine("Localização", document.data["Localização"]),
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
  verificador(bool key){
    print(key);
    if(key == true){
      return  itemLine("Observações", document.data["Observações"]);
    }
    else{
      return Container();
    }
  }
}
