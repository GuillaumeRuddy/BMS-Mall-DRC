import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mall_drc/pages/maps_page.dart';

import '../app/app_constatns.dart';

class Coordonne extends StatefulWidget {
  const Coordonne({Key? key}) : super(key: key);

  @override
  State<Coordonne> createState() => _CoordonneState();
}

class _CoordonneState extends State<Coordonne> {
  String? long;
  String? lat;

  TextEditingController nomCtrl = TextEditingController();
  TextEditingController adresseCtrl = TextEditingController();
  TextEditingController detailCtrl = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(children: [
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      nomChampSaisie(),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () async {
                            LatLng? reponse = await Navigator.push<LatLng>(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => MapsPage()));
                            ;
                            if (reponse != null) {
                              long = "${reponse.longitude}";
                              lat = "${reponse.latitude}";
                              print(reponse.latitude);
                              print(reponse.longitude);
                            }
                          },
                          child: Text('Aller vers la Carte')),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              //    Spacer(),
              boutonEnvoyer(context)
            ],
          ),
        ),
      ]),
    );
  }

  Widget nomChampSaisie() {
    return TextFormField(
      controller: nomCtrl,
      readOnly: true,
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value == null || value.isEmpty) return "Champ obligatoire";
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.timer,
            color: Colors.grey,
          ),
          labelText: "Prix unitaire",
          labelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.6),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white70),
    );
  }

  Widget descriptionChampSaisie() {
    return TextFormField(
      controller: nomCtrl,
      readOnly: true,
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value == null || value.isEmpty) return "Champ obligatoire";
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.timer,
            color: Colors.grey,
          ),
          labelText: "Prix unitaire",
          labelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.6),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white70),
    );
  }
}
