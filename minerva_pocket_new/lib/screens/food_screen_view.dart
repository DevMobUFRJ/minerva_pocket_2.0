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
            height: 500,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
