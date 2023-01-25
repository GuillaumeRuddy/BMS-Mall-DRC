// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mall_drc/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}



/*

import 'package:async/async.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/controler/commande/commandeController.dart';
import 'package:mall_drc/controler/panier/panierController.dart';
import 'package:mall_drc/controler/produits/produitController.dart';
import 'package:mall_drc/pages/categories.dart';
import 'package:mall_drc/pages/livraison.dart';
import 'package:mall_drc/pages/list_commande.dart';
import 'package:mall_drc/pages/notification.dart';
import 'package:mall_drc/pages/nouveaute.dart';
import 'package:mall_drc/pages/panier.dart';
import 'package:mall_drc/pages/profil.dart';
import 'package:mall_drc/widgets/drawer.dart';
import 'package:mall_drc/widgets/produit_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mall_drc/model/category.dart';

import '../controler/categorie/categorieController.dart';
import '../model/categorie.dart';
import '../model/category.dart';
import '../model/produit.dart';
import '../widgets/category_card.dart';
import '../widgets/circle_button.dart';
import '../widgets/search_testfield.dart';
import 'details.dart';
import 'map.dart';
import 'marchant.dart';

class Home extends StatefulWidget {
  String? idt;
  Home({Key? key, this.idt}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex = 0;
  var utilisateur;
  List<Produit> listProduits = [];
  List<Produit> listProduitsLimit = [];
  List<Produit> listProduitRecherche = [];
  List<Categorie> listCategories = [];
  String? ident;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //recupSession();
    ident = widget.idt;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //await recupidSession();
      utilitaire.lancerChargementDialog4(context);
      var prodCtrl = context.read<ProduitController>();
      await prodCtrl.RecupProduit();
      await prodCtrl.RecupProduitLimit("4");
      listProduits = prodCtrl.prod;
      listProduitsLimit = prodCtrl.prodLimit;
      print("----------- les produits ----------");
      print(listProduits);
      print("------ fin list des produits ------");

      await Future.delayed(Duration(milliseconds: 800));
      // quitter la boite de dialogue de chargement
      Navigator.pop(context);

      setState(() {});
    });
  }

  recupProduit() async {
    var prodCtrl = context.read<ProduitController>();
    await prodCtrl.RecupProduit();
    listProduits = prodCtrl.prod;
    return listProduits;
  }

  recupProduitLimit() async {
    var prodCtrl = context.read<ProduitController>();
    await prodCtrl.RecupProduitLimit('4');
    listProduitsLimit = prodCtrl.prodLimit;
    print("--------------------------------------------------------------");
    print(listProduitsLimit);
    for (var element in listProduitsLimit) {
      print(element.id);
      print(element.nom);
      print(element.prix);
    }
    print("--------------------------------------------------------------");
    return listProduitsLimit;
  }

  recupProduitRecherche(String valeur) async {
    var prodCtrl = context.read<ProduitController>();
    await prodCtrl.RechercheProduit(valeur);
    listProduitRecherche = prodCtrl.prodRecherche;
    return listProduitRecherche;
  }

  Future recupCategories() async {
    var catCtrl = context.read<CategorieController>();
    await catCtrl.RecupCategorie();
    listCategories = catCtrl.listDesCategorie;
    setState(() {});
    //await recupCategorie();
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
              badgeContent: Consumer<CommandeController>(
                builder: ((context, value, child) {
                  return FutureBuilder(
                      future: value.recupNombreCmd(),
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
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
                        .push(MaterialPageRoute(builder: (_) => Activite()));
                  },
                  child: Icon(
                    Icons.card_giftcard_rounded,
                    size: 30,
                  )),
            )

                /*Badge(
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
                      /*Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => MapAdr()));*/
                    },
                    child: Icon(
                      Icons.card_giftcard_rounded,
                      size: 30,
                    )),
              ),*/

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
          Padding(
            padding: EdgeInsets.all(5),
            child: InkWell(
                onTap: () {
                  showSearch(
                      context: context,
                      delegate:
                          _MyDelegate(listDesProdRecherche: listProduits));
                },
                child: Icon(
                  Icons.search,
                  size: 30,
                )),
          )
        ],
      ),
      drawer: DrawerAdd(),
      body: (listProduitsLimit == null || listProduits == null)
          ? Center(child: Text('Chargement des données en cours...'))
          : SingleChildScrollView(
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
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                            InkWell(
                              onTap: () {
                                showSearch(
                                    context: context, delegate: _MyDelegate());
                              },
                              child: TextFormField(
                                //onChanged: ,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 26,
                                  ),
                                  /*suffixIcon: const Icon(
                              Icons.mic,
                              color: Colors.blue,
                              size: 26,
                            ),*/
                                  // helperText: "Search your topic",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: "Rechercher un produit",
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  isDense: true,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ACCES RAPIDE",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.blueR),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Boutique
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Livraison()));
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 180,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.blue),
                                          child: Column(
                                            children: [
                                              Center(
                                                  child: Icon(
                                                Icons.local_shipping,
                                                color: Colors.white,
                                                size: 75,
                                              )),
                                              Text(
                                                "Livraison",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white),
                                              )
                                            ],
                                          )),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //Restaurant
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Categories()));
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 180,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.blue),
                                          child: Column(
                                            children: [
                                              Center(
                                                  child: Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                                size: 75,
                                              )),
                                              Text(
                                                "Achat",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white),
                                              )
                                            ],
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "NOUVEAUTE",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.blueR),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: recupProduitLimit(),
                          builder: (context, snapshot) {
                            List<Produit>? prod =
                                snapshot.data as List<Produit>?;
                            print("Le type de valeur dans home");
                            print(prod.runtimeType);
                            if (snapshot.hasData) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    /*buildCard(1),
                              SizedBox(
                                width: 12,
                              ),
                              buildCard(2),
                              SizedBox(
                                width: 12,
                              ),
                              buildCard(3),
                              SizedBox(
                                width: 12,
                              ),
                              buildCard(4),
                              SizedBox(
                                width: 12,
                              ),
                              buildCard(5),
                              SizedBox(
                                width: 12,
                              ),
                              buildCard(6),
                              SizedBox(
                                width: 12,
                              ),
                              buildCard(7),
                              SizedBox(
                                width: 12,
                              ),
                              buildCard(8),*/
                                    ListView.builder(
                                      //scrollDirection: Axis.horizontal,
                                      itemCount: prod!.length,
                                      //physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ProduitCard(
                                          prod: listProduitsLimit[index],
                                        );
                                      },
                                    ),
                                    /*GridView.builder(
                                shrinkWrap: true,
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
                                    prod: listProduitsLimit[index],
                                  );
                                },
                              ),*/
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text("chargement des données..."));
                            }
                          }),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "LE TOP DES PRODUITS",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.ecrit),
                            ),
                            InkWell(
                              onTap: () {},
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Nouveaute()));
                                },
                                child: Text("voir plus",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red[800])),
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                      .push(MaterialPageRoute(builder: (_) => Categories()));
                },
                child: Icon(
                  Icons.category,
                  size: 24.0,
                ),
              ),
              icon: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Categories()));
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
                        future: value.getNbrItemPanier(ident ?? ""),
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
                        future: value.getNbrItemPanier(ident ?? ""),
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

  Widget buildCard(int i) => Container(
        color: Colors.red,
        width: 150,
        height: 150,
        child: Center(child: Text(i.toString())),
      );
}

class _MyDelegate extends SearchDelegate {
  List<Produit>? listDesProdRecherche;
  _MyDelegate({this.listDesProdRecherche});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    /*List<Produit> ListSugestion =
        listDesProdRecherche!.where((unProduit) => {
          final resultat = unProduit!.toLowerCase();
          final input = query.toLowerCase();
          return resultat.contains(input);
        }).toList();*/
    return ListView.builder(
        itemCount: listDesProdRecherche!.length,
        itemBuilder: (context, index) {
          final suggestion = listDesProdRecherche![index];
          return ListTile(
              title: Text(suggestion.nom!),
              onTap: () {
                query = suggestion.nom!;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Details(
                          product: suggestion,
                        )));
                showResults(context);
              });
        });
  }
}



 */