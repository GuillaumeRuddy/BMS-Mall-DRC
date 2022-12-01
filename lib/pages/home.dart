import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/controler/panier/panierController.dart';
import 'package:mall_drc/controler/produits/produitController.dart';
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

class Home extends StatefulWidget {
  //String? idt;
  const Home({
    Key? key,
    /*this.idt*/
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex = 0;
  var utilisateur;
  List<Produit> listProduits = [];
  String? ident;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //recupSession();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //await recupidSession();
      await recupProduit();
    });
  }

  Future recupProduit() async {
    var prodCtrl = context.read<ProduitController>();
    await prodCtrl.RecupProduit();
    listProduits = prodCtrl.prod;
    print("----------- les produits ----------");
    print(listProduits);
    print("------ fin list des produits ------");
    setState(() {});
  }

  Future recupSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("user");
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
        title: Text("Mall DRC", style: TextStyle(color: AppColors.ecrit)),
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

              /*Badge(
                badgeColor: Colors.red,
                //padding: EdgeInsets.all(5),
                badgeContent: Text(
                  "0",
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    onPressed: () /*async*/ {
                      /*final pref = await SharedPreferences.getInstance();
                    pref.setBool("showPres", false);*/
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Message()));
                    },
                    icon: Icon(Icons.card_giftcard_sharp)),
              ),*/
            ),
          ),
        ],
      ),
      drawer: DrawerAdd(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*Container(
              color: AppColors.blueR,
              padding: EdgeInsets.all(20),
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
                  Spacer(),
                  Icon(
                    Icons.more_vert,
                    size: 25.0,
                    color: Colors.white,
                  )
                ],
              ),
            ),*/
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                              future: recupSession(),
                              builder: (context, snapshot) {
                                var user = snapshot.data;
                                return Row(
                                  children: [
                                    Text(
                                      "Salut! $user",
                                      style: GoogleFonts.poppins(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                );
                              }),

                          /*CircleButton(
                            icon: Icons.account_circle,
                            onPressed: () {},
                          ),*/
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SearchTextField()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "CATEGORIE",
                        style: GoogleFonts.poppins(
                          color: AppColors.ecrit,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => Categorie()));
                        },
                        child: Text(
                          "voir plus",
                          style: TextStyle(
                              color: Colors.red[800],
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Boutique
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  child: Center(
                                      child: Icon(
                                    Icons.shopping_bag,
                                    color: Colors.white,
                                  ))),
                              Text("Boutique")
                            ],
                          ),
                        ),
                      ),
                      //Restaurant
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  child: Center(
                                      child: Icon(
                                    Icons.restaurant,
                                    color: Colors.white,
                                  ))),
                              Text("Restaurant")
                            ],
                          ),
                        ),
                      ),
                      //Marcher
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  child: Center(
                                      child: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ))),
                              Text("Marcher")
                            ],
                          ),
                        ),
                      ),
                      //Pharmacie
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  child: Center(
                                      child: Icon(
                                    Icons.local_pharmacy,
                                    color: Colors.white,
                                  ))),
                              Text("Pharmacie")
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  child: Center(
                                      child: Icon(
                                    Icons.dashboard,
                                    color: Colors.white,
                                  ))),
                              Text("Autres")
                            ],
                          ),
                        ),
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
                        "NOUVEAUTE",
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
      
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
          backgroundColor: AppColors.blueR,
          elevation: 0,
          items: [
            //Accueil
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home,
                size: 24.0,
              ),
              icon: Icon(
                Icons.home_outlined,
                size: 24.0,
              ),
              label: "Accueil",
            ),
            //categorie
            BottomNavigationBarItem(
              activeIcon: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Categorie()));
                },
                child: Icon(
                  Icons.category,
                  size: 24.0,
                ),
              ),
              icon: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Categorie()));
                },
                child: Icon(
                  Icons.category_outlined,
                  size: 24.0,
                ),
              ),
              label: "Categorie",
            ),
            //panier
            BottomNavigationBarItem(
              activeIcon: Badge(
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
                      Icons.shopping_cart,
                      size: 30,
                    )),
              ),
              icon: Badge(
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
              label: "Panier",
            ),
            //profil
            BottomNavigationBarItem(
              activeIcon: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DetailUser()));
                },
                child: Icon(
                  Icons.person,
                  size: 24.0,
                ),
              ),
              icon: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DetailUser()));
                },
                child: Icon(
                  Icons.person_outline,
                  size: 24.0,
                ),
              ),
              label: "Profil",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
