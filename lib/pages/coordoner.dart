import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/controler/commande/commandeController.dart';
import 'package:mall_drc/db/db_mall.dart';
import 'package:mall_drc/pages/coordoner.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/success.dart';
import 'package:mall_drc/widgets/cardPanier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controler/panier/panierController.dart';
import '../model/produit.dart';
import '../widgets/rien.dart';

class Coordonne extends StatefulWidget {
  const Coordonne({Key? key}) : super(key: key);

  @override
  State<Coordonne> createState() => _CoordonneState();
}

class _CoordonneState extends State<Coordonne> {
  List<Produit> ListProduit = [];
  var panierCtrl;
  Map resultat = {};
  TextEditingController nomCtrl = TextEditingController();
  TextEditingController adresseCtrl = TextEditingController();
  TextEditingController detailCtrl = TextEditingController();
  TextEditingController userController = TextEditingController();

  DbMAll baseDD = DbMAll();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      panierCtrl = context.read<PanierController>();
      ListProduit = await panierCtrl.getData();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //var panierCtrl = context.read<PanierController>();
    return Scaffold(
      body: ListView(
        children: [
          //entete Coordonne
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
                    "Adresse",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          //details
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 700,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(77, 233, 230, 230),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0),
                        nomChampSaisie(),
                        SizedBox(height: 20.0),
                        adresseChampSaisie(),
                        SizedBox(height: 20.0),
                        descriptionChampSaisie(),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: //Validation et montant total
          BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /*Consumer<PanierController>(
                builder: (context, value, child) {
                  return Visibility(
                    visible: value.prixTotal == "0.0" ? false : true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Montant total:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "${value.prixTotal}\$",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900]),
                        )
                      ],
                    ),
                  );
                },
              ),*/
              InkWell(
                onTap: () {
                  envoyerDonner();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.blueR,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "PASSE COMMANDE",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.ecrit,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget nomChampSaisie() {
    return TextFormField(
      autofocus: false,
      controller: nomCtrl,
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      textAlignVertical: TextAlignVertical.bottom,
      //maxLength: 9,
      onChanged: (value) {
        setState(() {
          //counterText = value.length.toString();
        });

        /*if (value.length > 3) {
          setState(() {
            valid = true;
          });
        } else {
          valid = false;
        } */
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.book,
            color: Colors.blue,
            size: 26,
          ),
          contentPadding: EdgeInsets.only(bottom: 10, top: 22, left: 10),
          //counterText: '$counterText/09',
          counterStyle: TextStyle(
            fontSize: 10,
          ),
          labelText: 'Lieu',
          //labelStyle: ,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Entrez le titre de lemplacement',
          border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    );
  }

  Widget adresseChampSaisie() {
    return TextFormField(
      autofocus: false,
      controller: adresseCtrl,
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      textAlignVertical: TextAlignVertical.bottom,
      //maxLength: 9,
      onChanged: (value) {
        setState(() {
          //counterText = value.length.toString();
        });

        /*if (value.length > 3) {
          setState(() {
            valid = true;
          });
        } else {
          valid = false;
        } */
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.place_outlined,
            color: Colors.blue,
            size: 26,
          ),
          contentPadding: EdgeInsets.only(bottom: 10, top: 22, left: 10),
          //counterText: '$counterText/09',
          counterStyle: TextStyle(
            fontSize: 10,
          ),
          labelText: 'Adresse',
          //labelStyle: ,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Entrez votre adresse',
          border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    );
  }

  Widget residenceChampSaisie() {
    return TextFormField(
      autofocus: false,
      controller: userController,
      keyboardType: TextInputType.text,
      cursorColor: Colors.red,
      textAlignVertical: TextAlignVertical.bottom,
      //maxLength: 9,
      onChanged: (value) {
        setState(() {
          //counterText = value.length.toString();
        });

        /*if (value.length > 3) {
          setState(() {
            valid = true;
          });
        } else {
          valid = false;
        } */
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.account_circle_sharp,
            color: Colors.blue,
            size: 26,
          ),
          contentPadding: EdgeInsets.only(bottom: 10, top: 22, left: 10),
          //counterText: '$counterText/09',
          counterStyle: TextStyle(
            fontSize: 10,
          ),
          labelText: 'Utilisateur',
          //labelStyle: ,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Entrez votre adresse email',
          border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    );
  }

  Widget descriptionChampSaisie() {
    return TextFormField(
      autofocus: false,
      controller: detailCtrl,
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      textAlignVertical: TextAlignVertical.bottom,
      //maxLength: 9,
      onChanged: (value) {
        setState(() {
          //counterText = value.length.toString();
        });

        /*if (value.length > 3) {
          setState(() {
            valid = true;
          });
        } else {
          valid = false;
        } */
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.more,
            color: Colors.blue,
            size: 26,
          ),
          contentPadding: EdgeInsets.only(bottom: 10, top: 22, left: 10),
          //counterText: '$counterText/09',
          counterStyle: TextStyle(
            fontSize: 10,
          ),
          labelText: 'D??tails',
          //labelStyle: ,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Entrez votre d??tail',
          border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    );
  }

  void envoyerDonner() async {
    utilitaire.lancerChargementDialog4(context);

    var ctrlCommande = context.read<CommandeController>();

    var ctrlPanier = context.read<PanierController>();
    ListProduit = await ctrlPanier.getData();

    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getInt("id").toString();

    for (var prod in ListProduit) {
      Map data = {
        "marchand_id": prod.marchand_id,
        "id_client": idUser,
        "id_produit": prod.id,
        "prix": prod.prix,
        "quantite": prod.quantite,
        "adresse": adresseCtrl.text,
        "description": detailCtrl.text,
        "modelivraison": "non",
        "prixdriver": 10000
      };

      print(data);

      resultat = await ctrlCommande.CommandeProduit(data);
      print('la commande a afficher ++++++++++++');
      print(resultat);
    }

    utilitaire.afficherSnack(context, resultat["msg"],
        resultat["status"] ? Colors.green : Colors.red);

    await Future.delayed(Duration(milliseconds: 800));

    if (resultat['status']) {
      Navigator.pop(context, true);
      baseDD.suppressionTousProduitPanier();
      reinit();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Success()));
    }
  }

  Future reinit() async {
    var ctrlPanier = await context.read<PanierController>();
    ctrlPanier.reinitAllPanier();
  }
}


































/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mall_drc/pages/success.dart';

import '../app/app_constatns.dart';

class Coordonne extends StatefulWidget {
  const Coordonne({Key? key}) : super(key: key);

  @override
  State<Coordonne> createState() => _CoordonneState();
}

class _CoordonneState extends State<Coordonne> {
  //String? long;
  //String? lat;

  TextEditingController nomCtrl = TextEditingController();
  TextEditingController adresseCtrl = TextEditingController();
  TextEditingController detailCtrl = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                    "Adresse",
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
                        //nomChampSaisie(),
                        SizedBox(
                          height: 20,
                        ),
                        //adresseChampSaisie(),
                        SizedBox(
                          height: 20,
                        ),
                        //descriptionChampSaisie(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                //    Spacer(),
              ],
            ),
          ),
        ]),
      ),*/
      /*bottomNavigationBar: //Validation et montant total
            BottomAppBar(
                child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: AppColors.blueR,
              borderRadius: BorderRadius.circular(1),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 3))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => Success()));
                },
                icon: Icon(CupertinoIcons.cart_badge_plus),
                label: Text(
                  "Valider",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.ecrit),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
              )
            ],
          ),
        ))*/
/*    );
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
          labelText: "Nom",
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

  Widget adresseChampSaisie() {
    return TextFormField(
      controller: adresseCtrl,
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
          labelText: "Adresse",
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
      controller: detailCtrl,
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
          labelText: "D??tails",
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
*/































/*import 'package:flutter/cupertino.dart';
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
    return Scaffold(
        body: Form(
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
                          descriptionChampSaisie(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //    Spacer(),
                ],
              ),
            ),
          ]),
        ),
        bottomNavigationBar: //Validation et montant total
            BottomAppBar(
                child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: AppColors.blueR,
              borderRadius: BorderRadius.circular(1),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 3))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(CupertinoIcons.cart_badge_plus),
                label: Text(
                  "Valider",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.ecrit),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
              )
            ],
          ),
        )));
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
          labelText: "Nom",
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
      controller: detailCtrl,
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
          labelText: "D??tails",
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
}*/
