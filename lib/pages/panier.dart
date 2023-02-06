import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/adresse.dart';
import 'package:mall_drc/pages/checkout.dart';
import 'package:mall_drc/pages/coordoner.dart';
import 'package:mall_drc/pages/echec_panier.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/success.dart';
import 'package:mall_drc/widgets/cardPanier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/endPoint.dart';
import '../controler/panier/panierController.dart';
import '../db/db_mall.dart';
import '../model/produit.dart';
import '../widgets/rien.dart';

class Panier extends StatefulWidget {
  Panier({Key? key}) : super(key: key);

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  List<Produit> ListProduit = [];
  String? ident;
  bool voir = false;
  DbMAll bd = DbMAll();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recupId();
  }

  double calculMontTotProduit(double prix, double qte) {
    double montantTotProduit = prix * qte;
    return montantTotProduit;
  }

  recupId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ident = pref.getInt("id").toString();
    setState(() {});
  }

  recupPanier(String id) async {
    var ctrlPanier = context.read<PanierController>();
    ListProduit = await ctrlPanier.getDataById(id);
    return ListProduit;
  }

  etatPanier() async {
    List<Produit> produits = await recupPanier(ident ?? "");
    if (produits.isEmpty) {
      voir = false;
      setState(() {});
    } else {
      voir = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    //var panierCtrl = context.read<PanierController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Panier",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
      ),
      body: FutureBuilder(
          future: recupPanier(ident ?? ""),
          builder: (context, snapshot) {
            List<Produit>? user = snapshot.data as List<Produit>?;
            print("Le type de valeur dans le produit");
            print(user.runtimeType);
            if (snapshot.hasData) {
              if (user!.isEmpty) {
                voir = false;
                return echecPanier();
              } else {
                voir = true;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: user.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            //xdruser.remove(index);
                            /*return PanierCard(
                              nom: user[index].nom,
                              prix: user[index].prix,
                              monniae: user[index].monnaie,
                              id: user[index].id,
                              qte: user[index].quantite,
                              image: user[index].image,
                            );*/
                            var ctrlPanier = context.read<PanierController>();
                            return Container(
                              height: 110,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 10)
                                  ]),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    margin: EdgeInsets.only(right: 15),
                                    child: Image.network(
                                      "${ApiUrl.baseUrl}/${user[index].image ?? "assets/splash_icon.png"}",
                                      height: 80.0,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(3.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user[index].nom ?? "",
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17,
                                                  color: AppColors.ecrit),
                                        ),
                                        Row(
                                          //mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Qte: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15,
                                                      color: AppColors.blueR),
                                            ),
                                            Text(
                                              user[index].quantite ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15,
                                                      color: AppColors.ecrit),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${user[index].prix}" +
                                              " ${user[index].monnaie}",
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: AppColors.blueR),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                        onPressed: () {
                                          ctrlPanier.diminuerCtrPanier();
                                          print("je supprime ici");
                                          print(double.parse(
                                              user[index].quantite!));
                                          print(user[index].prix!);
                                          double mont = user[index].prix! *
                                              double.parse(
                                                  user[index].quantite!);
                                          print(mont);
                                          ctrlPanier.diminuerPrixTotal(mont);
                                          //ctrlPanier.supressionItemPanier(widget.id!);
                                          bd.suppressionProduitPanier(
                                              user[index].id!);
                                          user.remove(index);
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 30,
                                        )),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      bottomNavigationBar: basDePage(),
    );
  }

  seFaireLivre() {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              //backgroundColor: AppColors.blueR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                height: 200,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.blueR,
                        child: Image(
                          image: AssetImage("assets/splash_icon.png"),
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      color: AppColors.blueR,
                      child: SizedBox.expand(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text(
                                "Voulez-vous, vous faire livré?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => MesAdresses()));
                                      },
                                      child: Text("Oui",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (_) => CheckoutPage(
                                                      livraison: false,
                                                    )));
                                      },
                                      child: Text("Non",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ));
  }

  basDePage() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 160,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<PanierController>(
            builder: (context, value, child) {
              return Visibility(
                visible: voir,
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Montant total:",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                          SizedBox(
                            width: 8,
                          ),
                          Text("${value.getPrixTotal()} \CDF",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[800]))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.black,
                        height: 10,
                      ),
                      Container(
                        height: 10,
                        child: VerticalDivider(),
                      ),
                      InkWell(
                        onTap: () {
                          seFaireLivre();
                        },
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.ecrit),
                          onPressed: () {
                            seFaireLivre();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "valider",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        /*Container(
                                  height: 50,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.blueR,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "PASSER COMMANDE",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.ecrit,
                                    ),
                                  ),
                                ),*/
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}






















    /*
    
    Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Montant total:",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                              Text(
                                "${value.getPrixTotal()}",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
    
    
     */