import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:latlong2/latlong.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/controler/adresse/adresseController.dart';
import 'package:mall_drc/controler/commande/commandeController.dart';
import 'package:mall_drc/db/db_mall.dart';
import 'package:mall_drc/model/adresse.dart';
import 'package:mall_drc/pages/adresse.dart';
import 'package:mall_drc/pages/coordoner.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/map.dart';
import 'package:mall_drc/pages/map_adresse.dart';
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
  bool valDefaut = false;
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
      appBar: AppBar(
        title: Text(
          "Création Adresse",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.ecrit),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              nomChampSaisie(),
              SizedBox(height: 20.0),
              adresseChampSaisie(),
              /*SizedBox(height: 20.0),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => MapAdr()));
                  },
                  child: Icon(
                    Icons.place,
                    size: 40,
                  )),*/
              SizedBox(height: 20.0),
              /*TextButton(
                  onPressed: () async {
                    var reponse = await Navigator.push<String>(context,
                        MaterialPageRoute(builder: (ctx) => MapAdresse()));

                    if (reponse != null) {
                      /*long = "${reponse.longitude}";
                              lat = "${reponse.latitude}";*/
                      /*print(reponse.latitude);
                      print(reponse.longitude);*/
                      print(reponse);
                    }
                  },
                  child: Text('Aller vers la Carte')),*/
              SizedBox(height: 20.0),
              descriptionChampSaisie(),
              SizedBox(height: 20.0),
              defautChampSaisie(),
              SizedBox(height: 40.0),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  //ce bouton fonctionne uniquement si le numero est valid
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        //Prend la couleur bleu si numero valid sinon grise
                        primary: AppColors.ecrit),
                    onPressed: () {
                      ajouterAdresse();
                      if (valDefaut) {
                        enregsitrerDefVal();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Ajouter Adresse",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nomChampSaisie() {
    return TextFormField(
        keyboardType: TextInputType.text,
        controller: nomCtrl,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nom',
            hintText: 'Saisir le titre de votre adresse'
            /*prefix: Icon(
            Icons.book,
            color: AppColors.blueR,
            size: 26,
          ),
          icon: Icon(
            Icons.book,
            color: AppColors.blueR,
            size: 26,
          ),*/
            ));

    /*  autofocus: false,
      controller: nomCtrl,
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      textAlignVertical: TextAlignVertical.bottom,
      //maxLength: 9,
      onChanged: (value) {
        setState(() {
          //counterText = value.length.toString();
        });
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.book,
            color: AppColors.blueR,
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
    );*/
  }

  Widget adresseChampSaisie() {
    return TextFormField(
        keyboardType: TextInputType.text,
        controller: adresseCtrl,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'adresse',
          hintText: "Saisir les coordonées de votre adresse",
          /*prefix: Icon(
            Icons.book,
            color: AppColors.blueR,
            size: 26,
          ),*/
          suffixIcon: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => MapAdr()));
              },
              color: Colors.grey,
              icon: Icon(
                Icons.map,
                color: Colors.black,
                size: 30,
              )),

          /*IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => MapAdr()));
              },
              color: Colors.grey,
              icon: Icon(
                Icons.map,
                color: Colors.black,
                size: 30,
              )),*/
        ));

    /*TextFormField(
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
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.place_outlined,
            color: AppColors.blueR,
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
    );*/
  }

  Widget descriptionChampSaisie() {
    return TextFormField(
        keyboardType: TextInputType.text,
        controller: detailCtrl,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'description',
            hintText: 'Saisir une description de votre adresse'
            /*prefix: Icon(
            Icons.book,
            color: AppColors.blueR,
            size: 26,
          ),
          icon: Icon(
            Icons.book,
            color: AppColors.blueR,
            size: 26,
          ),*/
            ));

    /*TextFormField(
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
            color: AppColors.blueR,
            size: 26,
          ),
          contentPadding: EdgeInsets.only(bottom: 10, top: 22, left: 10),
          //counterText: '$counterText/09',
          counterStyle: TextStyle(
            fontSize: 10,
          ),
          labelText: 'Détails',
          //labelStyle: ,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Entrez votre détail',
          border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    );*/
  }

  Widget defautChampSaisie() {
    return Container(
      child: Row(
        children: [
          Text("Valeur par defaut"),
          Checkbox(
              value: valDefaut,
              onChanged: (bool? value) {
                if (value != null) {
                  setState(() {
                    valDefaut = value;
                  });
                }
              })
        ],
      ),
    );
  }

  void ajouterAdresse() {
    utilitaire.lancerChargementDialog4(context);
    var ctrlPanier = context.read<adresseController>();
    baseDD.InsertionAdresse(Adresse(
            id: null,
            nom: nomCtrl.text,
            adresse: adresseCtrl.text,
            description: detailCtrl.text))
        .then((value) async {
      print("adresse ajouter à la base de donnée");
      utilitaire.afficherSnack(context, "Adresse ajouter", Colors.green);
      await Future.delayed(Duration(milliseconds: 800));
      Navigator.pop(context, true);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => MesAdresses()));
    }).onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
      print("erreur dinsertion");
    });
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

  void enregsitrerDefVal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("nomAdresse", nomCtrl.text);
    await pref.setString("coordAdresse", adresseCtrl.text);
    await pref.setString("desc", detailCtrl.text);
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
          labelText: "Détails",
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
          labelText: "Détails",
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
