import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/model/produit.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/success.dart';
import 'package:provider/provider.dart';

import '../controler/produits/produitController.dart';
import '../model/category.dart';
import '../widgets/category_card.dart';
import '../widgets/produit_card.dart';

class Nouveaute extends StatefulWidget {
  const Nouveaute({Key? key}) : super(key: key);

  @override
  State<Nouveaute> createState() => _NouveauteState();
}

class _NouveauteState extends State<Nouveaute> {
  List<Produit> listProduits = [];

  recupProduit() async {
    var prodCtrl = context.read<ProduitController>();
    await prodCtrl.RecupProduit();
    listProduits = prodCtrl.prod;
    return listProduits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
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
                "Nouveaute",
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
      Container(
          height: 700,
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: Color.fromARGB(77, 233, 230, 230),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: SingleChildScrollView(
            child: FutureBuilder(
                future: recupProduit(),
                builder: (context, snapshot) {
                  List<Produit>? prod = snapshot.data as List<Produit>?;
                  print(prod.runtimeType);
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            //scrollDirection: Axis.horizontal,
                            itemCount: prod!.length,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 24,
                            ),
                            itemBuilder: (context, index) {
                              return ProduitCard(
                                prod: prod[index],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          )),
    ]));
  }
}
