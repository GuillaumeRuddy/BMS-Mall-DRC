import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mall_drc/controler/panier/panierController.dart';
import 'package:mall_drc/db/db_mall.dart';
import 'package:provider/provider.dart';

import '../app/app_constatns.dart';

class PanierCard extends StatelessWidget {
  String? image;
  String? nom;
  double? prix;
  String? qte;
  String? id;
  PanierCard({Key? key, this.nom, this.prix, this.image, this.id})
      : super(key: key);

  DbMAll bd = DbMAll();
  double montantTotProduit = 0.0;

  @override
  Widget build(BuildContext context) {
    var ctrlPanier = context.read<PanierController>();
    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 4,
              margin: EdgeInsets.only(right: 15),
              child: Image(
                image: AssetImage("assets/splash_icon.png"),
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nom ?? "",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.ecrit,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${prix.toString()}\$",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    IconButton(
                        onPressed: () {
                          bd.suppressionProduitPanier(id!);
                          ctrlPanier.diminuerCtrPanier();
                          ctrlPanier.diminuerPrixTotal(montantTotProduit);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    /*Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10)
                          ]),
                      child: Icon(
                        CupertinoIcons.plus,
                        size: 18,
                      ),
                    ),*/
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        qte ?? "",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    /*Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10)
                          ]),
                      child: Icon(
                        CupertinoIcons.minus,
                        size: 18,
                      ),
                    )*/
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  double calculMontTotProduit() {
    montantTotProduit = prix! * double.parse(qte!.toString());
    return montantTotProduit;
  }
}
