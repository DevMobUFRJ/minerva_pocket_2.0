import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class InfrastructureListScreenView extends StatefulWidget {
  final String idSubcategoria;
  final DocumentSnapshot document;
  InfrastructureListScreenView(this.idSubcategoria, this.document);

  @override
  _InfrastructureListScreenViewState createState() =>
      _InfrastructureListScreenViewState();
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

class _InfrastructureListScreenViewState
    extends State<InfrastructureListScreenView> {
  GeoPoint localizacao;
  Set<Marker> _markers = {};
  GoogleMapController mapController;
  Location location = Location();
  @override
  Widget build(BuildContext context) {
    print(widget.idSubcategoria);
    print(widget.document.data);
    localizacao = widget.document.data["localizacao"];
    return Scaffold(
        backgroundColor: Colors.white, body: widgetScreenView(context));
  }

  widgetScreenView(BuildContext context) {
    if (widget.idSubcategoria == "Banheiros")
      return academicBanheirosScreenView(context);
    else if (widget.idSubcategoria == "Bebedouros")
      return academicBebedourosScreenView(context);
    /*else if (widget.idSubcategoria == "CAs e DAs") {
      return academicCAsDasScreenView(context);
    } else if (widget.idSubcategoria == "Auditórios") {
      return academicAuditoriosScreenView(context);
    } else if (widget.idSubcategoria == "Secretarias") {
      return academicSecretariasScreenView(context);
    }*/
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

  Widget map() {
    return Container(
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
                markerId: MarkerId("oi"),
                position: LatLng(localizacao.latitude, localizacao.longitude),
                icon: BitmapDescriptor.defaultMarker,
                onTap: () {
                  MapUtils.openMap(localizacao.latitude, localizacao.longitude);
                }));
          });
        },
        initialCameraPosition: CameraPosition(
          // 1
          target: LatLng(localizacao.latitude, localizacao.longitude),
          // 2
          zoom: 20,
        ),
      ),
    );
  }

  Widget academicBanheirosScreenView(BuildContext context) {
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
                    width: double.maxFinite,
                    placeholder: kTransparentImage,
                    image: widget.document.data["image"],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                    child: Text(
                      widget.document.data["nome"],
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
        widgetVisible(widget.document),

        //itemLine("Localização", document.data["localizacao"]),
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
        map(),
      ],
    );
  }

  Widget academicBebedourosScreenView(BuildContext context) {
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
                    width: double.maxFinite,
                    placeholder: kTransparentImage,
                    image: widget.document.data["image"],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                    child: Text(
                      widget.document.data["nome"],
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
        widgetVisible(widget.document),

        //itemLine("Localização", document.data["localizacao"]),
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
        map(),
      ],
    );
  }

  Widget widgetVisible(DocumentSnapshot documentSnapshot) {
    List<Widget> widgets = [];
    if (documentSnapshot.data["centro"] != "null") {
      widgets.add(itemLine("Centro", documentSnapshot.data["centro"]));
    }
    if (documentSnapshot.data["tipo"] != "null") {
      widgets.add(
          itemLine("Tipo de Infraestrutura", documentSnapshot.data["tipo"]));
    }
    if (documentSnapshot.data["detalhes"] != "null") {
      widgets.add(itemLine("Detalhes", documentSnapshot.data["detalhes"]));
    }
    if (documentSnapshot.data["situacao"] != "null") {
      widgets.add(itemLine("Situação", documentSnapshot.data["situacao"]));
    }
    return new Column(children: widgets.toList());
  }

  //Inutilizável por enquanto
  verificador(bool key) {
    print(key);
    if (key == true) {
      return itemLine("Observações", widget.document.data["observacoes"]);
    } else {
      return Container();
    }
  }
}
