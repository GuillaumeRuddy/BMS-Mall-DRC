/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../app/app_constatns.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Set<Marker> markers = new Set();
  var defaultLatLng = LatLng(-4.00030, 15.9384);
  Completer<GoogleMapController> _controller = Completer();
  LatLng? coordVentes;
  CameraPosition? cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraPosition = CameraPosition(target: defaultLatLng, zoom: 14);
    /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var venteCtrl = context.read<VentesController>();
      var vente_selectionne = venteCtrl.venteSelectionne;
      print("liste ventes ${venteCtrl.ventes.length}");
  
      double totalLat = 0;
      double totalLong = 0;
      for (var vente in venteCtrl.ventes) {
        double latitude = double.parse(vente.latitude!);
        double longitude = double.parse(vente.longitude!);
        totalLat += latitude;
        totalLong += longitude;
        var couleurIcon = BitmapDescriptor.defaultMarker;
        if (vente.id == vente_selectionne?.id) {
          couleurIcon =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
        }
        markers.add(Marker(
          //add first marker
          markerId: MarkerId("${vente.id}"),
          position: LatLng(latitude, longitude), //position of marker
          infoWindow: InfoWindow(
            //popup info
            title: "${vente.produit}",
            snippet: "Quantite: ${vente.quantite}",
          ),
          icon: couleurIcon, //Icon for Marker
        ));
      }
      if (venteCtrl.ventes.length > 0) {
        var moyenneLat = totalLat / venteCtrl.ventes.length;
        var moyenneLong = totalLong / venteCtrl.ventes.length;
        cameraPosition =
            CameraPosition(target: LatLng(moyenneLat, moyenneLong), zoom: 13);
      }

      setState(() {});
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, coordVentes);
        return Future.value(false);
      },
      child: Scaffold(
          //appBar: entete(),
          body: ListView(
        children: [
          Container(
            color: AppColors.blueR,
            padding: EdgeInsets.all(15),
            //entete
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Carte",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          (cameraPosition == null)
              ? Center(child: Text('Chargement de la Carte'))
              : GoogleMap(
                  markers: markers,
                  onTap: (LatLng data) {
                    coordVentes = data;
                    markers.add(Marker(
                      //add first marker
                      markerId: MarkerId("MONID"),
                      position: data, //position of marker
                      infoWindow: InfoWindow(
                        //popup info
                        title: 'Nouveau point',
                        snippet: 'Position actuelle',
                      ),
                      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
                    ));

                    setState(() {});
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: cameraPosition!,
                ),
        ],
      )),
    );
  }

  /*AppBar entete() {
    return AppBar(
      title: Text(
        "Carte",
        style: TextStyle(color: Colors.black),
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0)),
      actions: [],
    );
  }*/
}*/
