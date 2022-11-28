import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/coordoner.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/success.dart';
import 'package:mall_drc/widgets/cardPanier.dart';
import 'package:provider/provider.dart';

import '../controler/panier/panierController.dart';
import '../model/produit.dart';
import '../widgets/rien.dart';

class Panier extends StatefulWidget {
  const Panier({Key? key}) : super(key: key);

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  List<Produit> ListProduit = [];
  var panierCtrl;

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
      body: ListView(
        children: [
          //entete Panier
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
                    "Panier",
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
          SingleChildScrollView(
            child: Column(
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
                    //mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: ListProduit.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PanierCard(
                            nom: ListProduit[index].nom,
                            prix: ListProduit[index].prix,
                            id: ListProduit[index].id,
                            qte: ListProduit[index].quantite,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: //Validation et montant total
          BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<PanierController>(
                builder: (context, value, child) {
                  return Visibility(
                    visible: value.prixTotal == "0.0" ? false : true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Montant total:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "${value.prixTotal}\$",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900]),
                        )
                      ],
                    ),
                  );
                },
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => Coordonne()));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.blueR,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "PASSE COMMANDE",
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