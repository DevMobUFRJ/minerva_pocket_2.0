import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

//Tela que mostra os dados do restaurante
//Localização ainda não funciona
//Tela precisa ser melhorada, sobretudo em questão de layout
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

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
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
                        image: widget.image,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                        child: Text(
                          widget.nome,
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_back,
                          color: Colors.white, size: 41.0),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            itemLine("Tipo", widget.tipo),
            itemLine("Preço", widget.preco),
            itemLine("Pagamento", widget.pagamento),
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
        ));
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
