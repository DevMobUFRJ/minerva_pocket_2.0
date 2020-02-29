import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

//Tela que mostra os dados do restaurante
//Localização ainda não funciona
//Tela precisa ser melhorada, sobretudo em questão de layout
class FoodScreenView extends StatefulWidget {
  final String nome;
  final String image;
  final String tipo;
  final String preco;
  final String pagamento;
  final String funcionamento;
  final GeoPoint localizacao;

  FoodScreenView(this.nome, this.image, this.tipo, this.preco, this.pagamento,
      this.funcionamento, this.localizacao);

  @override
  _FoodScreenViewState createState() => _FoodScreenViewState();
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class _FoodScreenViewState extends State<FoodScreenView> {
  Set<Marker> _markers = {};
  GoogleMapController mapController;
  Location location = Location();
  Marker marker;
  @override
  void initState() {
    super.initState();
    print(widget.localizacao.toString());
    /*location.onLocationChanged().listen((location) async {
      if(marker != null) {
        mapController.removeMarker(marker);
      }
      marker = await mapController?.addMarker(MarkerOptions(
        position: LatLng(location["latitude"], location["longitude"]),
      ));
      mapController?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              location["latitude"],
              location["longitude"],
            ),
            zoom: 20.0,
          ),
        ),
      );
    });*/
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
            itemLine("Funcionamento", widget.funcionamento),
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
              height: 300.0,
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                mapType: MapType.normal,
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  setState(() {
                    _markers.add(Marker(
                        infoWindow: InfoWindow(
                          title: widget.nome,
                        ),
                        markerId: MarkerId("oi"),
                        position: LatLng(widget.localizacao.latitude,
                            widget.localizacao.longitude),
                        icon: BitmapDescriptor.defaultMarker,
                        onTap: () {
                          MapUtils.openMap(widget.localizacao.latitude,
                              widget.localizacao.longitude);
                        }));
                  });
                },
                initialCameraPosition: CameraPosition(
                  // 1
                  target: LatLng(widget.localizacao.latitude,
                      widget.localizacao.longitude),
                  // 2
                  zoom: 20,
                ),
              ),
            ),
          ],
        ));
  }
}
