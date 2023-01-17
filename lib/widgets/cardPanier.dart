import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mall_drc/controler/panier/panierController.dart';
import 'package:mall_drc/db/db_mall.dart';
import 'package:provider/provider.dart';

import '../app/app_constatns.dart';
import '../app/endPoint.dart';

class PanierCard extends StatefulWidget {
  String? image;
  String? nom;
  double? prix;
  String? qte;
  String? id;
  String? monniae;
  PanierCard(
      {Key? key,
      this.nom,
      this.prix,
      this.image,
      this.id,
      this.qte,
      this.monniae})
      : super(key: key);

  @override
  State<PanierCard> createState() => _PanierCardState();
}

class _PanierCardState extends State<PanierCard> {
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10)
          ]),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 4,
            margin: EdgeInsets.only(right: 15),
            child: Image.network(
              "${ApiUrl.baseUrl}/${widget.image ?? "assets/splash_icon.png"}",
              height: 80.0,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  widget.nom ?? "",
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.ecrit,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Qte: ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blueR,
                          ),
                        ),
                        Text(
                          widget.qte ?? "",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.ecrit,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "${widget.prix.toString()}" + " ${widget.monniae}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Container(
            child: IconButton(
                onPressed: () {
                  ctrlPanier.diminuerCtrPanier();
                  print("je supprime ici");
                  print(double.parse(widget.qte!.toString()));
                  print(widget.prix);
                  double mont =
                      widget.prix! * double.parse(widget.qte!.toString());
                  print(mont);
                  ctrlPanier.diminuerPrixTotal(mont);
                  ctrlPanier.supressionItemPanier(widget.id!);
                  setState(() {});
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          )
        ],
      ),
    );
  }

  double calculMontTotProduit() {
    montantTotProduit = widget.prix! * double.parse(widget.qte!.toString());
    return montantTotProduit;
  }
}
