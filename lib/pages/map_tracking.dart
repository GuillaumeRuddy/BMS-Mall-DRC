import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/controler/commande/commandeController.dart';
import 'package:mall_drc/model/driver.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_constatns.dart';
import '../app/endPoint.dart';

class MapTracking extends StatefulWidget {
  String? idDriver;
  MapTracking({super.key, this.idDriver});

  @override
  State<MapTracking> createState() => _MapTrackingesseState();
}

class _MapTrackingesseState extends State<MapTracking> {
  //String cleAPIGoogle = "AIzaSyCOezElHw_-X9BTbMwFVkg-XLKllqrXA_E";
  String cleAPIGoogle = "AIzaSyCOezElHw_-X9BTbMwFVkg-XLKllqrXA_E";
  LatLng currentLocation = LatLng(-4.3205782, 15.2949903);
  LatLng driverLocation = LatLng(-4.3205782, 15.2949903);
  //LatLng driverLocation = LatLng(37.33429383, -122.06600055);
  late Completer<GoogleMapController> mapControle = Completer();
  List<LatLng> polylineCoordinates = [];

  final Set<Marker> markers = new Set();
  CameraPosition? cameraPosition;

  //Map<String, Marker> mesMarkers = {};
  String adresse = "";
  Placemark? monAdresse;
  Driver? unDriver;
  /*Map<String, Marker> mesMarkers = {};
  LatLng? unePosition;
  Driver? unDriver;
  */

  getPolyPoint() async {
    print(
        'moi: lattitude --> ${currentLocation.latitude}, longitude: ---> ${currentLocation.longitude}');
    print('API: **** ${cleAPIGoogle}');
    print(
        'dirver: lattitude --> ${driverLocation.latitude}, longitude: ---> ${driverLocation.longitude}');
    PolylinePoints polylinePoint = new PolylinePoints();
    PolylineResult result = await polylinePoint.getRouteBetweenCoordinates(
        cleAPIGoogle,
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(driverLocation.latitude, driverLocation.longitude));
    print("le resultat de polyPoint: ${result}");
    print("le resultat de poly ---Point: ${result.points}");
    if (result.points.isNotEmpty) {
      print("je suis dans le if de polyline");
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        print(polylineCoordinates);
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getLocationDriver();
      await getCurrentLocation();
      markers.add(Marker(
          markerId: MarkerId("Ma Position"),
          position: currentLocation,
          infoWindow: InfoWindow(
            title: "Ma Position",
            snippet: "Position: ${currentLocation}",
          )));
      markers.add(Marker(
          markerId: MarkerId("Driver"),
          position: driverLocation,
          infoWindow: InfoWindow(
            title: "Driver",
            snippet: "Position: ${driverLocation}",
          )));
      cameraPosition = CameraPosition(target: currentLocation, zoom: 16);
      setState(() {});
      getPolyPoint();
    });

    super.initState();
  }

  getLocationDriver() async {
    var ctrlDriver = context.read<CommandeController>();
    await ctrlDriver.recupDriver(widget.idDriver.toString());
    unDriver = ctrlDriver.ListDriver;
    print("*********le driver de la map que je recupere********** ${unDriver}");
    setState(() {
      //driverLocation = ctrlDriver.ListDriver;
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
    print(loc);
    double lat = loc.latitude;
    double long = loc.longitude;
    print(lat);
    print(long);

    setState(() {
      currentLocation = LatLng(lat, long);
    });
    /*mapControle!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation, zoom: 20)));*/
    /*List<Placemark> lieu = await placemarkFromCoordinates(lat, long);
    print("----------- Information de la place -------------");
    print(lieu);
    monAdresse = lieu[0];*/
    //mapControle.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation, zoom: 20)));
    setState(() {});
    return loc;
  }

  @override
  Widget build(BuildContext context) {
    //utilitaire.afficherSnack(context, "Veuillez selectioner vôtre adresse");
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);
          return true;
        },
        child: Scaffold(
          body: (cameraPosition == null)
              ? Center(child: Text('Chargement de la Carte...'))
              : Center(
                  child: Container(
                    child: GoogleMap(
                      initialCameraPosition: cameraPosition!,
                      polylines: {
                        Polyline(
                            polylineId: PolylineId("Route"),
                            points: polylineCoordinates,
                            color: Colors.red),
                      },
                      markers: markers,
                      /*markers: {
                Marker(
                    markerId: MarkerId("Ma Position"),
                    position: currentLocation),
                Marker(
                    markerId: MarkerId("Position driver"),
                    position: driverLocation)
              }*/
                    ),
                  ),
                ),
        ));
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

  /*void ajoutMarker(String? id, LatLng? coordonne, {String? couleur}) async {
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
        title: "${id}",
        snippet: "Position: ${id}",
      ),
      //icon: makerIcon,
      //icon: BitmapDescriptor.fromBytes(makerImg, size: const Size(1.0, 1.0))
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    mesMarkers[id] = place;
    setState(() {});
  }*/
}










































/*import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapTracking extends StatefulWidget {
  String? idDriver;
  MapTracking({super.key, this.idDriver});

  @override
  State<MapTracking> createState() => _MapTrackingState();
}

class _MapTrackingState extends State<MapTracking> {
  LatLng pointD = LatLng(-4.3804066, 15.3473766);
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
}*/
























































/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/controler/commande/commandeController.dart';
import 'package:mall_drc/model/driver.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_constatns.dart';
import '../app/endPoint.dart';

class MapTracking extends StatefulWidget {
  String? idDriver;
  MapTracking({super.key, this.idDriver});

  @override
  State<MapTracking> createState() => _MapTrackingesseState();
}

class _MapTrackingesseState extends State<MapTracking> {
  LatLng currentLocation = LatLng(-4.3804066, 15.3473766);
  LatLng? driverLocation;
  GoogleMapController? mapControle;
  String adresse = "";
  Map<String, Marker> mesMarkers = {};
  LatLng? unePosition;
  Driver? unDriver;
  Placemark? monAdresse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCurrentLocation(); /*.then((value) {
        double lat = value.latitude;
        double long = value.longitude;
        print('le initstate');
        print(lat);
        print(long);
        currentLocation = LatLng(lat, long);
        mapControle!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLocation, zoom: 20)));
        setState(() {});
      });*/
      var driverCtrl = context.read<CommandeController>();
      if (widget.idDriver != "non") {
        await driverCtrl.recupDriver(widget.idDriver!);
        unDriver = await driverCtrl.ListDriver;
        driverLocation = LatLng(double.parse(unDriver!.latitude!),
            double.parse(unDriver!.longitude!));
      }
      print('******** les informatioins du driver pour la latitude');
      print(driverLocation);
      setState(() {});
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
    /*mapControle!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation, zoom: 20)));*/
    List<Placemark> lieu = await placemarkFromCoordinates(lat, long);
    print("----------- Information de la place -------------");
    print(lieu);
    monAdresse = lieu[0];
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
          Navigator.pop(context);
          /*Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));*/
          return true;
          //return Future.value(true);
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
                          "le type de doné de la localisation dans le future builder");
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
        title: "${monAdresse!.subLocality}",
        snippet: "${monAdresse!.thoroughfare}",
      ),
      //icon: makerIcon,
      //icon: BitmapDescriptor.fromBytes(makerImg, size: const Size(1.0, 1.0))
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    mesMarkers[id] = place;
    setState(() {});
  }
}*/
