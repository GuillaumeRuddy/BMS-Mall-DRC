import 'dart:math';

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
import 'package:mall_drc/widgets/produit_card2.dart';
import 'package:mall_drc/widgets/produit_card3.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mall_drc/model/category.dart';

import '../app/endPoint.dart';
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
      //utilitaire.lancerChargementDialog4(context);
      await recupProduitLimit();
      await recupProduit();
      /*var prodCtrl = context.read<ProduitController>();
      await prodCtrl.RecupProduit();
      await prodCtrl.RecupProduitLimit("4");
      listProduits = prodCtrl.prod;
      listProduitsLimit = prodCtrl.prodLimit;
      print("----------- les produits ----------");
      print(listProduits);
      print("------ fin list des produits ------");

      await Future.delayed(Duration(milliseconds: 800));
      // quitter la boite de dialogue de chargement
      Navigator.pop(context);*/

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
    var taille = MediaQuery.of(context).size;
    return Scaffold(
      /*
      *****************************
      Le AppBar du homePage
      *****************************
       */
      appBar: AppBar(
        title: Text("Mall DRC", style: TextStyle(color: AppColors.ecrit)),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
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
            )),
          ),
          /*Padding(
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
          )*/
        ],
      ),
      /*
      *****************************
      Le Drawer du homePage
      *****************************
       */
      drawer: DrawerAdd(),
      /*
      *****************************
      Le body du homePage
      *****************************
       */
      body: (listProduitsLimit == null ||
              listProduits == null ||
              listProduitsLimit.isEmpty ||
              listProduits.isEmpty)
          ? Center(child: Text('Chargement des données en cours...'))
          : ListView(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(children: [
                    //Salutation et Partie de recherche
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
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
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                height: 40,
                              ),
                              //CARD DE LIVRAISON ET ACHAT
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 5, right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Boutique
                                    Expanded(
                                      flex: 2,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      EnvoieLivraison()));
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                  width: 170,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white),
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
                                      flex: 2,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      Categories()));
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                  width: 170,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white),
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
                              /*InkWell(
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
                                      labelStyle: const TextStyle(color: Colors.grey),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                )*/
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    //TEXTE ACCES RAPIDE
                    /*Padding(
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
                    ),*/

                    const SizedBox(
                      height: 5,
                    ),
                    //TITRE DE NOUVEAUTE
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
                    //LES ELEMENTS DE NOUVEAUTE
                    /*SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ListView.builder(
                            itemCount: listProduitsLimit.length,
                            itemBuilder: (BuildContext context, int index) {
                              /*return ProduitCard(
                              prod: listProduitsLimit[index],
                            );*/
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    Image.network(
                                      "${ApiUrl.baseUrl}/" +
                                          listProduitsLimit[index].image!,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(listProduitsLimit[index].nom!)
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),*/
                    //Affichage mais
                    /*ListView.builder(
                      //shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(12),
                      itemCount: listProduitsLimit.length,
                      itemBuilder: (BuildContext context, int index) {
                        return builCard(listProduitsLimit[
                            index]); /*ProduitCard3(
                          prod: listProduitsLimit[index],
                        );*/ /*ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => DetailUser()));
                            },
                            title: Text(
                              listProduitsLimit[index].nom!,
                              maxLines: 1,
                            ),
                            subtitle: Text(
                              listProduitsLimit[index].description!,
                              maxLines: 2,
                            ),
                          );*/ /*Column(
                                              children: [
                          /*ProduitCard(
                            prod: listProduitsLimit[index],
                          ),*/
                          
                                              ],
                                            );*/
                      },
                      /*separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          thickness: 1,
                          color: Colors.grey,
                                              ),*/
                    ),*/
                    /*ListView.builder(
                  //scrollDirection: Axis.horizontal,
                  itemCount: listProduitsLimit.length,
                  //physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    /*return ProduitCard(
                              prod: listProduitsLimit[index],
                            );*/
                    return Text("information");
                  },
                ),*/
                    //LE TITRE DE TOP PRODUITS
                    /*Padding(
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
                      ),*/
                    //LES DONNEES DU TOP DES PRODUITS
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
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 14,
                      ),
                      itemBuilder: (context, index) {
                        return ProduitCard3(
                          prod: listProduits[index],
                        );
                      },
                    ),
                  ]),
                ),
              ],
            ),
      //PIED DECRAN
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
            //recherche
            BottomNavigationBarItem(
              activeIcon: InkWell(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate:
                            _MyDelegate(listDesProdRecherche: listProduits));
                  },
                  child: Icon(
                    Icons.search_outlined,
                    size: 30,
                  )),
              icon: InkWell(
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
              label: "Recherche",
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

  Widget builCard(Produit pro) {
    return Container(
      color: Colors.red,
      width: 150,
      height: 150,
      child: Center(
        child: Text(pro.nom!),
      ),
    );
  }
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
    return Center(
        child: query.isNotEmpty
            ? Text(query)
            : Text("Aucun resultat trouver pour vôtre recherche"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Produit> ListSugestion = listDesProdRecherche!.where((unProduit) {
      var resultat = unProduit.nom!.toLowerCase();
      var input = query.toLowerCase();
      return resultat.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: ListSugestion.length,
        itemBuilder: (context, index) {
          final suggestion = ListSugestion[index];
          return ListTile(
              leading: Image.network(
                "${ApiUrl.baseUrl}/" + suggestion.image!,
                height: 50,
              ),
              title: Text(suggestion.nom!, maxLines: 1),
              subtitle: Text(
                suggestion.description!,
                maxLines: 1,
              ),
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
