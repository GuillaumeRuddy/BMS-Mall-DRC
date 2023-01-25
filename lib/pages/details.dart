import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/db/db_mall.dart';
import 'package:mall_drc/model/produit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_constatns.dart';
import '../app/endPoint.dart';
import '../controler/panier/panierController.dart';

class Details extends StatefulWidget {
  Produit product;
  Details({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int qteCommande = 1;
  late Produit px;
  late double prixTotal = qteCommande * (px.prix as double);
  late double prix = px.prix as double;
  double montantTotProduit = 0.0;
  String? idClient;

  DbMAll? dbMAll = DbMAll();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    px = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                      "Détail produit",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  //Spacer(),
                  /*Icon(
                  Icons.more_vert,
                  size: 25.0,
                  color: Colors.white,
                )*/
                ],
              ),
              //fin entete
            ),
            /* Image.network(
                "${ApiUrl.baseUrl}/" + prod.image!,
                height: 80.0,
              ) */
            Padding(
              padding: EdgeInsets.all(15),
              child: Image.network(
                "${ApiUrl.baseUrl}/" + px.image!,
                height: 280.0,
                width: 280,
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                px.nom ?? "",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                    color: AppColors.blueR),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "DESCRIPTION",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      //fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.ecrit),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  px.description ?? "",
                  textAlign: TextAlign.justify,
                  maxLines: 5,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      //fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.blueR),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "En Stock : ",
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            //fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColors.ecrit),
                      ),
                      Text(
                        px.quantite ?? "",
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: AppColors.blueR),
                      ),
                    ],
                  ),
                  /*SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 0.3,
                                    blurRadius: 5)
                              ]),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (qteCommande > 1) {
                                    qteCommande--;
                                    prixTotal = qteCommande * prix;
                                  }
                                });
                              },
                              icon: Icon(
                                CupertinoIcons.minus,
                                size: 18,
                                color: AppColors.ecrit,
                              ))),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "${qteCommande}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 0.3,
                                    blurRadius: 5)
                              ]),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  qteCommande++;
                                  print(qteCommande);
                                  prixTotal = qteCommande * prix;
                                  print(prixTotal);
                                });
                              },
                              icon: Icon(
                                CupertinoIcons.plus,
                                size: 18,
                                color: AppColors.ecrit,
                              )))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    "Prix unitaire : ",
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        //fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppColors.ecrit),
                  ),
                  /*SizedBox(
                  width: 10,
                ),*/
                  Text(
                    px.prix.toString(),
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: AppColors.blueR),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    px.monnaie ?? "",
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: AppColors.blueR),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
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
              Text(
                prixTotal.toString() + " ${px.monnaie}",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Colors.white),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await recupIdSession();
                  ajouterAuPAnier();
                  utilitaire.afficherSnack(
                      context, "un article ajouter au panier", Colors.green);
                  Navigator.pop(context);
                  //reinit();
                },
                icon: Icon(CupertinoIcons.cart_badge_plus),
                label: Text(
                  "Ajouter au panier",
                  style: Theme.of(context).textTheme.button!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
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

  void ajouterAuPAnier() {
    var ctrlPanier = context.read<PanierController>();
    print("voila l'image que j'envoie: ${px.image}");
    dbMAll!
        .InsertionProduit(Produit(
            nom: px.nom,
            prix: px.prix,
            quantite: "${qteCommande}",
            description: px.description,
            image: px.image,
            marchand_id: px.marchand_id,
            monnaie: px.monnaie,
            idClient: idClient))
        .then((value) {
      print("produit ajouter au panier");
      var ctrlPanier = context.read<PanierController>();
      print("le type du prix est :   ${px.prix.runtimeType}");
      print("le type de quantite est :   ${px.quantite.runtimeType}");
      double valtot = calculMontTotProduit(px.prix!, qteCommande);
      print(valtot);
      ctrlPanier.ajoutPrixTotal(valtot);
      ctrlPanier.ajoutCtrPanier();
    }).onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    });
  }

  Future recupIdSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idClient = pref.getInt("id").toString();
  }

  double calculMontTotProduit(double prix, int qte) {
    print("le prix est de ---  ${prix}");
    print("la qte est de ---  ${qte}");
    montantTotProduit = prix * qte;
    print(montantTotProduit);
    return montantTotProduit;
  }

  void reinit() {
    var ctrlp = context.read<PanierController>();
    ctrlp.reinitialiserItemPanier();
  }
}
