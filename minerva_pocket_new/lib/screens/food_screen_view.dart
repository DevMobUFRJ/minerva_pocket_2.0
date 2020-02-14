import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodScreenView extends StatefulWidget {
  final String nome;
  final String image;
  final String tipo;
  final String preco;
  final String pagamento;
  final String localizacao;

  FoodScreenView(this.nome, this.image, this.tipo, this.preco, this.pagamento,
      this.localizacao);

  @override
  _FoodScreenViewState createState() => _FoodScreenViewState();
}

class _FoodScreenViewState extends State<FoodScreenView> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  /*Map<String, dynamic> maps = new Map<String, dynamic>();
  Future getList() async {
    var firestore = Firestore.instance;

    DocumentReference docRef = firestore
        .collection("home")
        .document(widget.foodScreenId)
        .collection("restaurantes")
        .document(widget.idDocument);
    docRef.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        maps["nome"] = datasnapshot.data["nome"];
        maps["image"] = datasnapshot.data["image"];
        print(maps["image"]);
      }
    });
  }
    @override
  initState() {
    super.initState();
      setState(() {
        getList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              //Image.network(documents[index].data["image"]),
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: widget.image,
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
                  widget.nome,
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
                    widget.tipo,
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
                    widget.preco,
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
                    widget.pagamento,
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
          Container(
            height: 200,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          )
        ],
      ),
    );
    //getList();
    //print(maps["nome"]);
    /*Firestore.instance
          .collection("home")
          .document(widget.foodScreenId)
          .collection("restaurantes")
          .document(widget.idDocument)
          .get()
          .then((DocumentSnapshot) {
                  print(DocumentSnapshot.data["image"]);
        maps["nome"] = DocumentSnapshot.data["nome"];
        maps["tipo"] = DocumentSnapshot.data["tipo"];
        maps["Preços"] = DocumentSnapshot.data["Preços"];
        maps["Pagamento"] = DocumentSnapshot.data["Pagamento"];
        maps["Localização"] = DocumentSnapshot.data["Localização"];
        maps["image"] = DocumentSnapshot.data["image"];
      });
    return Container(
      color: Colors.white,
      child: ListView(children: <Widget>[
        Stack(children: <Widget>[
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: maps["image"],
            fit: BoxFit.cover,
          ),
          GestureDetector(
            child: Icon(
              Icons.arrow_back,
              size: 35.0,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 135.0, left: 10.0),
            child: Text(
              maps["nome"],
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ]),
        Column(
          children: <Widget>[Text(maps["tipo"])],
        )
      ]),
    );*/
    /*return Container(
        child: FutureBuilder(
      future: getList(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          //print(maps["nome"]);
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          default:
            return ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    //Image.network(documents[index].data["image"]),
                    Image.network(maps["image"]),
                    Container(
                      padding: EdgeInsets.only(top: 135.0, left: 10.0),
                      child: Text(
                        maps["nome"],
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            );
        }
      },
    ));*/
  }
}
