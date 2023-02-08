import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/controler/livraison/livraisonController.dart';
import 'package:mall_drc/controler/livraison/livraisoncontroller.dart';
import 'package:mall_drc/model/adresse.dart';
import 'package:mall_drc/model/livraison.dart';
import 'package:mall_drc/model/produit.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/map.dart';
import 'package:mall_drc/pages/map_adresse.dart';
import 'package:mall_drc/pages/map_tracking.dart';
import 'package:mall_drc/pages/notification.dart';
import 'package:mall_drc/pages/success.dart';
import 'package:mall_drc/widgets/cardAdresse.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_constatns.dart';
import '../controler/panier/panierController.dart';
import '../db/db_mall.dart';
import '../model/livraison.dart';
import 'adresse.dart';
import 'coordoner.dart';

class DetailsLivraison extends StatefulWidget {
  Livraison? livrsn;
  DetailsLivraison({Key? key, this.livrsn}) : super(key: key);

  @override
  State<DetailsLivraison> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<DetailsLivraison> {
  Livraison? livraison;
  bool? livrer;
  String? livr = "250";
  bool voir = false;
  bool acpt = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    livraison = widget.livrsn;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Détails de la livraison",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Référence ',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    livraison!.reference ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.red),
                  ),
                ],
              ),
              Divider(),
              const SizedBox(height: 15.0),
              Text(
                "Informations sur le l'éxpéditeur",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColors.ecrit),
              ),
              const SizedBox(height: 18.0),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nom:",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        livraison!.nom!,
                        style:
                            Theme.of(context).textTheme.subtitle2!.copyWith(),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Adresse:",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${livraison!.adresse!}",
                        style:
                            Theme.of(context).textTheme.subtitle2!.copyWith(),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Téléphone:",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${livraison!.telephone}",
                        style:
                            Theme.of(context).textTheme.subtitle2!.copyWith(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
              Text(
                "Informations sur le colis",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColors.ecrit),
              ),
              const SizedBox(height: 18.0),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Emplacement:",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        livraison!.emplacement!,
                        style:
                            Theme.of(context).textTheme.subtitle2!.copyWith(),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Détails:",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${livraison!.details!}",
                          maxLines: 5,
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                "Informations sur le destinataire",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColors.ecrit),
              ),
              const SizedBox(height: 18.0),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nom:",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        livraison!.nomDestinataire!,
                        style:
                            Theme.of(context).textTheme.subtitle2!.copyWith(),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Adresse:",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${livraison!.adresseDestination!}",
                        style:
                            Theme.of(context).textTheme.subtitle2!.copyWith(),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Téléphone:",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${livraison!.telephoneDestination}",
                        style:
                            Theme.of(context).textTheme.subtitle2!.copyWith(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Résumer",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.red),
                ),
              ),
              const SizedBox(height: 18.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Status:",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          status(),
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Montant:",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "18.000",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Monnaie:",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " CDF",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: Colors.red),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Stack(
                  children: [
                    Visibility(
                      visible: voir,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: AppColors.ecrit),
                        onPressed: () async {
                          print(
                              "******** ce que je passe comme valeur au tracking ${livraison!.attribution}");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => MapTracking(
                                    idDriver: livraison!.attribution,
                                  )));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Tracker la livraison",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: acpt,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: AppColors.ecrit),
                        onPressed: () {
                          //confimerRecup();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "livraison recu",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  status() {
    if (livraison!.attribution == "nom" && livraison!.statut == "non livré") {
      voir = false;
      acpt = false;
      return Text(
        "En cours de traitement",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: AppColors.ecrit),
      );
    } else if (livraison!.attribution == "nom" &&
        livraison!.statut == "livré") {
      voir = false;
      acpt = false;
      return Text(
        "livré",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.green),
      );
    } else if (livraison!.attribution != "non" &&
        livraison!.statut == "non livré") {
      voir = true;
      acpt = false;
      return Text(
        "En route",
        style:
            Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.blue),
      );
    } else if (livraison!.attribution != "non" &&
        livraison!.statut == "livré") {
      voir = false;
      acpt = false;
      return Text(
        "livré",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.green),
      );
    } else if (livraison!.attribution != "non" &&
        livraison!.statut == "en cours") {
      voir = true;
      acpt = false;
      return Text(
        "en cours",
        style:
            Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.blue),
      );
    } else {
      voir = false;
      acpt = false;
      return Text(
        "Annuler",
        style:
            Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.red),
      );
    }
  }
}





/*


Stack(
                    children: [
                      Visibility(
                        visible: voir,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.ecrit),
                          onPressed: () async {
                            print(
                                "******** ce que je passe comme valeur au tracking ${livraison!.attribution}");
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MapTracking(
                                      idDriver: livraison!.attribution,
                                    )));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Tracker la livraison",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: acpt,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.ecrit),
                          onPressed: () {
                            //confimerRecup();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "livraison recu",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

 */





//Condition status
/*

status() {
    if (livraison!.attribution == "nom" && livraison!.statut == "non livré") {
      voir = false;
      acpt = false;
      return Text(
        "En traitement",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: AppColors.ecrit),
      );
    } else if (livraison!.attribution == "non" &&
        livraison!.statut == "en cours") {
      voir = true;
      acpt = false;
      return Text(
        "En route",
        style:
            Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.blue),
      );
    } else if (livraison!.attribution != "vide" &&
        livraison!.statut == "livré") {
      voir = false;
      acpt = false;
      return Text(
        "livré",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.green),
      );
    } else if (livraison!.attribution != "vide") {
      voir = true;
      acpt = false;
      return Text(
        "En route",
        style:
            Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.blue),
      );
    } else if (livraison!.statut == "0") {
      /*setState(() {
        voir = false;
      });*/
      setState(() {
        voir = false;
        acpt = true;
      });

      return Text(
        "passer moi-même",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.green),
      );
    } else {
      /*setState(() {
        voir = false;
      });*/
      voir = false;
      acpt = false;
      return Text(
        "Annuler",
        style:
            Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.red),
      );
    }
  }

 */