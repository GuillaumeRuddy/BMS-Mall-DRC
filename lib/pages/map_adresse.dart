import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_constatns.dart';
import '../app/endPoint.dart';

class MapAdresse extends StatefulWidget {
  const MapAdresse({super.key});

  @override
  State<MapAdresse> createState() => _MapAdresseState();
}

class _MapAdresseState extends State<MapAdresse> {
  LatLng currentLocation = LatLng(25.1193, 55.3773);
  late GoogleMapController mapControle;
  String adresse = "";
  Map<String, Marker> mesMarkers = {};
  LatLng? unePosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCurrentLocation().then((value) {
        double lat = value.latitude;
        double long = value.longitude;
        print(lat);
        print(long);
        currentLocation = LatLng(lat, long);
        /*mapControle.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLocation, zoom: 20)));*/
        setState(() {});
      });
    });
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
    currentLocation = LatLng(lat, long);
    //mapControle.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation, zoom: 20)));
    setState(() {});
    return loc;
  }

  @override
  Widget build(BuildContext context) {
    //utilitaire.afficherSnack(context, "Veuillez selectioner vôtre adresse");
    return WillPopScope(
        onWillPop: () async {
          /*Navigator.pop(context, adresse);*/
          /*Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
          return true;*/
          //return Future.value(true);
          Navigator.pop(context, true);
          Navigator.pop(context, true);
          return true;
        },
        child: Scaffold(
            appBar: entete(),
            body: Container(
              child: FutureBuilder<Position>(
                  future: getCurrentLocation(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Position> snapshot) {
                    if (snapshot.hasData) {
                      print(
                          "le type de donéé de la localisation dans le future builder");
                      print(snapshot.data.runtimeType);
                      return GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition:
                            CameraPosition(target: currentLocation, zoom: 20),
                        onMapCreated: (controller) async {
                          mapControle = controller;
                          ajoutMarker("Ma position", currentLocation);
                        },
                        markers: mesMarkers.values.toSet(),
                        onTap: (tapPosition) {
                          setState(() {
                            print(tapPosition);
                            unePosition = tapPosition;
                            print(tapPosition.runtimeType);
                            ajoutMarker('tap', unePosition!);
                          });
                        },
                      );
                    }
                    return Center(
                      child: Text(
                        "chargement de la Map en cours...",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }),
            )));
  }

  AppBar entete() {
    return AppBar(
      title: Text(
        "Carte",
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
      ),
      elevation: 0.0,
      backgroundColor: AppColors.blueR,
    );
  }

  void ajoutMarker(String? id, LatLng? coordonne, {String? couleur}) async {
    // creation d'une image person pour le markeur
    SharedPreferences pref = await SharedPreferences.getInstance();
    var imageUser = pref.getString("image");
    var imgUrl = "${ApiUrl.baseUrl}/${imageUser}";
    var makerImg = (await NetworkAssetBundle(Uri.parse(imgUrl)).load(imgUrl))
        .buffer
        .asUint8List();

    // creation d'une icone pour le markeur
    var makerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/drawer.png");
    // Le marker
    var place = Marker(
      markerId: MarkerId(id!),
      position: coordonne!,
      infoWindow: InfoWindow(
        //popup info
        title: id,
        snippet: "Emplacement: ${id}",
      ),
      //icon: makerIcon,
      //icon: BitmapDescriptor.fromBytes(makerImg, size: const Size(1.0, 1.0))
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    mesMarkers[id] = place;
    setState(() {});
  }
}



/*

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_constatns.dart';
import '../app/endPoint.dart';

class MapAdresse extends StatefulWidget {
  const MapAdresse({super.key});

  @override
  State<MapAdresse> createState() => _MapAdresseState();
}

class _MapAdresseState extends State<MapAdresse> {
  LatLng currentLocation = LatLng(15.2690364, 55.3773);
  late GoogleMapController mapControle;
  String adresse = "";
  Map<String, Marker> mesMarkers = {};
  LatLng? unePosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCurrentLocation().then((value) {
        double lat = value.latitude;
        double long = value.longitude;
        print(lat);
        print(long);
        currentLocation = LatLng(lat, long);
        mapControle.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLocation, zoom: 20)));
        setState(() {});
      });
    });
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
    currentLocation = LatLng(lat, long);
    //mapControle.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation, zoom: 20)));
    setState(() {});
    return loc;
  }

  @override
  Widget build(BuildContext context) {
    //utilitaire.afficherSnack(context, "Veuillez selectioner vôtre adresse");
    return WillPopScope(
        onWillPop: () async {
          /*Navigator.pop(context, adresse);*/
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
          return Future.value(true);
        },
        child: Scaffold(
            appBar: entete(),
            body: Container(
                child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition:
                  CameraPosition(target: currentLocation, zoom: 20),
              onMapCreated: (controller) async {
                mapControle = controller;
                ajoutMarker("Ma position", currentLocation);
              },
              markers: mesMarkers.values.toSet(),
              onTap: (tapPosition) {
                setState(() {
                  print(tapPosition);
                  unePosition = tapPosition;
                  print(tapPosition.runtimeType);
                  ajoutMarker('tap', unePosition!);
                });
              },
            )

                /*FutureBuilder<Position>(
                  future: getCurrentLocation(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Position> snapshot) {
                    if (snapshot.hasData) {
                      print(
                          "le type de donéé de la localisation dans le future builder");
                      print(snapshot.data.runtimeType);
                      return GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition:
                            CameraPosition(target: currentLocation, zoom: 20),
                        onMapCreated: (controller) async {
                          mapControle = controller;
                          ajoutMarker("Ma position", currentLocation);
                        },
                        markers: mesMarkers.values.toSet(),
                        onTap: (tapPosition) {
                          setState(() {
                            print(tapPosition);
                            unePosition = tapPosition;
                            print(tapPosition.runtimeType);
                            ajoutMarker('tap', unePosition!);
                          });
                        },
                      );
                    }
                    return Center(
                      child: Text(
                        "chargment de la Map en cours...",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }),*/
                )));
  }

  AppBar entete() {
    return AppBar(
      title: Text(
        "Carte",
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
      ),
      elevation: 0.0,
      backgroundColor: AppColors.blueR,
    );
  }

  void ajoutMarker(String? id, LatLng? coordonne, {String? couleur}) async {
    // creation d'une image person pour le markeur
    SharedPreferences pref = await SharedPreferences.getInstance();
    var imageUser = pref.getString("image");
    var imgUrl = "${ApiUrl.baseUrl}/${imageUser}";
    var makerImg = (await NetworkAssetBundle(Uri.parse(imgUrl)).load(imgUrl))
        .buffer
        .asUint8List();

    // creation d'une icone pour le markeur
    var makerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/drawer.png");
    // Le marker
    var place = Marker(
      markerId: MarkerId(id!),
      position: coordonne!,
      infoWindow: InfoWindow(
        //popup info
        title: id,
        snippet: "Emplacement: ${id}",
      ),
      //icon: makerIcon,
      //icon: BitmapDescriptor.fromBytes(makerImg, size: const Size(1.0, 1.0))
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    mesMarkers[id] = place;
    setState(() {});
  }
}


 */