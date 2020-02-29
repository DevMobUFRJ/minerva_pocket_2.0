import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class TotalLocationTab extends StatefulWidget {
  @override
  _TotalLocationTabState createState() => _TotalLocationTabState();
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

class _TotalLocationTabState extends State<TotalLocationTab> {
  GeoPoint localizacao;
  Set<Marker> _markers = {};
  GoogleMapController mapController;
  Location location = Location();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("locations").getDocuments(),
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
              for (int i = 0; i < documents.length; i++) {
                localizacao = documents[i].data["localizacao"];
                _markers.add(Marker(
                    infoWindow: InfoWindow(
                      title: documents[i].data["nome"],
                    ),
                    markerId: MarkerId(documents[i].documentID),
                    position:
                        LatLng(localizacao.latitude, localizacao.longitude),
                    icon: BitmapDescriptor.defaultMarker,
                    onTap: () {
                      MapUtils.openMap(
                          localizacao.latitude, localizacao.longitude);
                    }));
              }
              //print(documents.length);
              return Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  mapType: MapType.normal,
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
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
        });
  }
}
