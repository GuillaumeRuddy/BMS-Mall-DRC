import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/adresse.dart';
import 'package:mall_drc/pages/checkout.dart';
import 'package:mall_drc/pages/coordoner.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/success.dart';
import 'package:mall_drc/widgets/cardPanier.dart';
import 'package:provider/provider.dart';

import '../controler/panier/panierController.dart';
import '../model/produit.dart';
import '../widgets/rien.dart';

class Panier extends StatefulWidget {
  Panier({Key? key}) : super(key: key);

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  List<Produit> ListProduit = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var ctrlPanier = context.read<PanierController>();
      ListProduit = await ctrlPanier.getData();
      setState(() {});
    });
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
      body: //details
          SingleChildScrollView(
        //je vais utiliser ici un space evely our différencier les panier ainsi que les autres points
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 700,
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: Color.fromARGB(77, 233, 230, 230),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: ListProduit.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PanierCard(
                        nom: ListProduit[index].nom,
                        prix: ListProduit[index].prix,
                        monniae: ListProduit[index].monnaie,
                        id: ListProduit[index].id,
                        qte: ListProduit[index].quantite,
                        image: ListProduit[index].image,
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<PanierController>(
                    builder: (context, value, child) {
                      return Visibility(
                        visible: value.getPrixTotal() == 0 ? false : true,
                        child: Column(
                          children: [
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Montant total:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  "${value.getPrixTotal()}\CDF",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[900]),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          //backgroundColor: AppColors.blueR,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Container(
                                            height: 200,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: AppColors.blueR,
                                                    child: Image(
                                                      image: AssetImage(
                                                          "assets/splash_icon.png"),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  color: AppColors.blueR,
                                                  child: SizedBox.expand(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(15.0),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Voulez-vous, vous faire livré?",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (_) =>
                                                                                MesAdresses()));
                                                                  },
                                                                  child: Text(
                                                                      "Oui",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color: Colors
                                                                              .blue,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (_) => CheckoutPage(
                                                                                  livraison: false,
                                                                                )));
                                                                  },
                                                                  child: Text(
                                                                      "Non",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color: Colors
                                                                              .blue,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
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
                              },
                              child: Container(
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
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




/*FutureBuilder(
    future: panierCtrl.getData(),
    builder:
        (context, AsyncSnapshot<List<Produit>> snapshot) {
      if (snapshot.hasData) {
        print("----- le retour du snapshoot -----");
        print(snapshot);
        print(snapshot.data);
        print(snapshot.data.runtimeType);
        print("----- fin du retour du snappshoot -----");
        return Expanded(
            child: ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Text(snapshot.data![index].nom.toString());

            /*Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start,
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image(
                          image: AssetImage(
                            snapshot.data![index].image.toString(),
                          ),
                          height: 100,
                          width: 100,
                        ),
                        /*SizedBox(width: 10,),
                        Expanded(child: child)*/
                      ],
                    )
                  ],
                ),
              ),
            );*/

            /*PanierCard(
                nom: snapshot.data![index].nom,
                prix: snapshot.data![index].prix,
                image: snapshot.data![index].image);*/
          },
        ));
      } else {
        return Center(
            child: AucuneDonne(
                imagePath: 'no_cart.png',
                text: "Aucun produit dans le panier"));
      }
    }) */





















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