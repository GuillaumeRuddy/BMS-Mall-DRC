import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapAdr extends StatefulWidget {
  const MapAdr({super.key});

  @override
  State<MapAdr> createState() => _MapAdrState();
}

class _MapAdrState extends State<MapAdr> {
  LatLng pointD = LatLng(51.509364, -0.08);
  var location = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCurrentLocation().then((value) {
        double lat = value.latitude;
        double long = value.longitude;
        print(lat);
        print(long);
        pointD = LatLng(lat, long);
        setState(() {});
      });
    });*/
  }

  Future<Position> getCurrentLocation() async {
    //check si le service de location est activé
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Service de localisation desactivé');
    }

    //permet de demander lacces
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('La permission de localisation a été refusé');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'la permission de la localisation permanente a été réfuse, nous ne pouvons pas repondre à votre requette.');
    }
    // ici on retourne la position
    var loc = await Geolocator.getCurrentPosition();
    double lat = loc.latitude;
    double long = loc.longitude;
    print(lat);
    print(long);
    pointD = LatLng(lat, long);
    //mapControle.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation, zoom: 20)));
    setState(() {});
    return loc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: Column(children: [
      Flexible(
          child: FlutterMap(
              options: MapOptions(
                onTap: ((tapPosition, point) {
                  setState(() {
                    print(point);
                    pointD = point;
                    print(tapPosition.runtimeType);
                  });
                }),
                center: pointD,
                zoom: 16,
              ),
              layers: [
            TileLayerOptions(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(
              markers: [
                Marker(
                    width: 100.0,
                    height: 100.0,
                    point: pointD,
                    builder: (ctx) => Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ))
              ],
            )
          ]))
    ]))));
  }
}









































/*

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../controller/ventes_controller.dart';
import '../utils.dart';

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
    //cameraPosition = CameraPosition(target: defaultLatLng, zoom: 14);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, coordVentes);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: entete(),
        body: (cameraPosition == null)
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
                      title: 'Nouveau point de vente',
                      snippet: 'ODC Subtitle',
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
      ),
    );
  }

  AppBar entete() {
    return AppBar(
      title: Text(
        "Carte",
        style: TextStyle(color: Utils.SECOND_TEXT_COLOR),
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
  }
}




 */