import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/controler/panier/panierController.dart';
import 'package:mall_drc/controler/produits/produitController.dart';
import 'package:mall_drc/model/marchant.dart';
import 'package:mall_drc/pages/categories.dart';
import 'package:mall_drc/pages/notification.dart';
import 'package:mall_drc/pages/nouveaute.dart';
import 'package:mall_drc/pages/panier.dart';
import 'package:mall_drc/pages/profil.dart';
import 'package:mall_drc/widgets/drawer.dart';
import 'package:mall_drc/widgets/produit_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mall_drc/model/category.dart';

import '../model/category.dart';
import '../model/produit.dart';
import '../widgets/category_card.dart';
import '../widgets/circle_button.dart';
import '../widgets/search_testfield.dart';

class Vendeur extends StatefulWidget {
  Marchand? march;
  Vendeur({Key? key, this.march}) : super(key: key);

  @override
  State<Vendeur> createState() => _VendeurState();
}

class _VendeurState extends State<Vendeur> {
  List<Produit> listProduits = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("objet passer en parametre ---------");
    print(widget.march);
    print(widget.march!.id);
    print(widget.march!.nomEntreprise);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var prodCtrl = context.read<ProduitController>();
      await prodCtrl.RecupProduitById(widget.march!.id.toString());
      listProduits = prodCtrl.prodById;
      print("----------- les produits par marchant ----------");
      print(listProduits);
      print("------ fin list des produits marchant ------");
      setState(() {});
    });
  }

  /*Future recupidSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ident = pref.getInt("id").toString();
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.march?.nomEntreprise}",
            style: TextStyle(color: AppColors.ecrit)),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
        actions: [
          /*IconButton(
              onPressed: () /*async*/ {
                /*final pref = await SharedPreferences.getInstance();
                pref.setBool("showPres", false);*/
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Message()));
              },
              icon: Icon(Icons.card_giftcard_sharp))*/
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Center(
              child: Badge(
                badgeColor: Colors.red,
                padding: EdgeInsets.all(5),
                badgeContent: Consumer<PanierController>(
                  builder: ((context, value, child) {
                    return FutureBuilder(
                        future: value.getNbrItemPanier(),
                        builder: (BuildContext context,
                            AsyncSnapshot<int> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data.toString(),
                              style: TextStyle(color: Colors.white),
                            );
                          }
                          return Text(
                            "0",
                            style: TextStyle(color: Colors.white),
                          );
                        });
                  }),
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Panier()));
                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Center(
              child: Badge(
                badgeColor: Colors.red,
                padding: EdgeInsets.all(5),
                badgeContent: Text(
                  "0",
                  style: TextStyle(color: Colors.white),
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Message()));
                    },
                    child: Icon(
                      Icons.card_giftcard_rounded,
                      size: 30,
                    )),
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerAdd(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Center(
                  child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.1, 0.5],
                      colors: [
                        AppColors.blue,
                        AppColors.blueR,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "heure de service: ",
                            style: GoogleFonts.poppins(
                                color: AppColors.ecrit,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${widget.march!.ouverture} /",
                            style: GoogleFonts.poppins(
                                color: Colors.blue,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${widget.march!.fermeture}",
                            style: GoogleFonts.poppins(
                                color: Colors.blue,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email: ",
                            style: GoogleFonts.poppins(
                                color: AppColors.ecrit,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${widget.march!.emailEntreprise}",
                            style: GoogleFonts.poppins(
                                color: Colors.blue,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Adresse: ",
                            style: GoogleFonts.poppins(
                                color: AppColors.ecrit,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${widget.march!.adresseEntreprise}",
                            style: GoogleFonts.poppins(
                                color: Colors.blue,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nouveaute",
                        style: GoogleFonts.poppins(
                          color: AppColors.ecrit,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => Nouveaute()));
                          },
                          child: Text(
                            "voir plus",
                            style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  //scrollDirection: Axis.horizontal,
                  itemCount: listProduits.length,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 24,
                  ),
                  itemBuilder: (context, index) {
                    return ProduitCard(
                      prod: listProduits[index],
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Les plus demander",
                        style: GoogleFonts.poppins(
                          color: AppColors.ecrit,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => Nouveaute()));
                          },
                          child: Text(
                            "voir plus",
                            style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  //scrollDirection: Axis.horizontal,
                  itemCount: listProduits.length,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 24,
                  ),
                  itemBuilder: (context, index) {
                    return ProduitCard(
                      prod: listProduits[index],
                    );
                  },
                ),
              ])),
            ),
          ],
        ),
      ),
    );
  }
}
