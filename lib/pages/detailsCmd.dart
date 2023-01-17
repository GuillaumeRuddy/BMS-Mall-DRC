import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/controler/commande/commandeController.dart';
import 'package:mall_drc/model/adresse.dart';
import 'package:mall_drc/model/commande.dart';
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
import 'adresse.dart';
import 'coordoner.dart';

class DetailsCmd extends StatefulWidget {
  bool? livraison;
  Commande? cmde;
  DetailsCmd({Key? key, this.livraison, this.cmde}) : super(key: key);

  @override
  State<DetailsCmd> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<DetailsCmd> {
  Commande? commande;
  bool? livrer;
  String? livr = "250";
  bool voir = false;
  bool acpt = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commande = widget.cmde;
    livrer = widget.livraison;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Détails de la commande",
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
                    'Référence: ',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    commande!.reference ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Addresse',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Container(
                  child: Center(
                      child: Text((commande!.aretirer! == "oui")
                          ? ""
                          : commande!.adresse!))),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      'Mode de reception',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13.0),
              Container(
                child: livrer != true
                    ? Text(
                        'Passer à la boutique',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 17,
                            color: AppColors.ecrit,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        'Livraison',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 17,
                            color: AppColors.ecrit,
                            fontWeight: FontWeight.bold),
                      ),
              ),
              const SizedBox(height: 72.0),
              Consumer<PanierController>(builder: (context, value, child) {
                return Column(
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
                          "Quantite:",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${commande!.quantite}",
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
                          "Montant:",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${commande!.prix} \CDF",
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
                          "Livraison:",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          livr! + " CDF",
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(),
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
                          "Montant TTC:",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${int.parse(livr!) + int.parse(commande!.prix!)} CDF",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: Colors.red),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Stack(
                      children: [
                        Visibility(
                          visible: voir,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.ecrit),
                            onPressed: () async {
                              print(
                                  "******** ce que je passe comme valeur au tracking ${commande!.attribution}");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => MapTracking(
                                        idDriver: commande!.attribution,
                                      )));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Tracker la commande",
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
                              confimerRecup();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Commande recu",
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
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void confimerRecup() async {
    utilitaire.lancerChargementDialog4(context);

    var ctrlCommande = context.read<CommandeController>();
    String idCmd = commande!.id!.toString();

    var resultat = await ctrlCommande.recupMoiMeme(idCmd);
    print('la commande a afficher ++++++++++++');
    print(resultat);

    utilitaire.afficherSnack(context, resultat["msg"],
        resultat["status"] ? Colors.green : Colors.red);

    await Future.delayed(Duration(milliseconds: 800));

    if (resultat['status']) {
      Navigator.pop(context, true);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Message()));
    }
  }

  status() {
    if ((commande!.attribution == "vide" && commande!.statut == "non livré") ||
        commande!.aretirer == "oui") {
      /*setState(() {
        voir = false;
      });*/
      voir = false;
      acpt = false;
      return Text(
        "En préparation",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: AppColors.ecrit),
      );
    } else if (commande!.attribution != "vide" &&
        commande!.statut == "en cours") {
      voir = true;
      acpt = false;
      return Text(
        "En route",
        style:
            Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.blue),
      );
    } else if (commande!.attribution != "vide" && commande!.statut == "livré") {
      /*setState(() {
        voir = false;
      });*/
      voir = false;
      acpt = false;
      return Text(
        "livré",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.green),
      );
    } else if (commande!.attribution != "vide") {
      voir = true;
      acpt = false;
      return Text(
        "En route",
        style:
            Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.blue),
      );
    } else if (commande!.aretirer == "oui") {
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
}
