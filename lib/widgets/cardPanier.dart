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
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
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
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 4,
            margin: EdgeInsets.only(right: 15),
            child: Image.network(
              "${ApiUrl.baseUrl}/${widget.image ?? "assets/splash_icon.png"}",
              height: 80.0,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.nom ?? "",
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
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
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.blueR),
                    ),
                    Text(
                      widget.qte ?? "",
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.ecrit),
                    ),
                  ],
                ),
                Text(
                  "${widget.prix.toString()}" + " ${widget.monniae}",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
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
                  size: 30,
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
