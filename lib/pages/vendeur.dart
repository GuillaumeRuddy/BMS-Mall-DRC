import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/controler/panier/panierController.dart';
import 'package:mall_drc/controler/produits/produitController.dart';
import 'package:mall_drc/model/marchant.dart';
import 'package:mall_drc/pages/categories.dart';
import 'package:mall_drc/pages/infos_vendeur.dart';
import 'package:mall_drc/pages/list_commande.dart';
import 'package:mall_drc/pages/nouveaute.dart';
import 'package:mall_drc/pages/panier.dart';
import 'package:mall_drc/pages/profil.dart';
import 'package:mall_drc/widgets/drawer.dart';
import 'package:mall_drc/widgets/drawer_vendeur.dart';
import 'package:mall_drc/widgets/produit_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mall_drc/model/category.dart';

import '../app/endPoint.dart';
import '../model/category.dart';
import '../model/produit.dart';
import '../widgets/category_card.dart';
import '../widgets/circle_button.dart';
import '../widgets/drawerMarchand.dart';
import '../widgets/search_testfield.dart';

class Vendeur extends StatefulWidget {
  Marchand? march;
  Vendeur({Key? key, this.march}) : super(key: key);

  @override
  State<Vendeur> createState() => _VendeurState();
}

class _VendeurState extends State<Vendeur> {
  List<Produit> listProduits = [];
  late Marchand unMarchand;
  late Stream<List<Produit>> listP;
  String? ident;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("objet passer en parametre ---------");
    print(widget.march);
    print(widget.march!.id);
    print(widget.march!.nomEntreprise);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      ident = pref.getInt("id").toString();
      utilitaire.lancerChargementDialog4(context);
      var prodCtrl = context.read<ProduitController>();
      await prodCtrl.RecupProduitById(widget.march!.id.toString());
      listProduits = prodCtrl.prodById;
      print("----------- les produits par marchant ----------");
      print(listProduits);
      print("------ fin list des produits marchant ------");
      await Future.delayed(Duration(milliseconds: 800));
      // quitter la boite de dialogue de chargement
      Navigator.pop(context);
      setState(() {});
    });
  }

  Future<List<Produit>> recuperationListProd() async {
    var prodCtrl = context.read<ProduitController>();
    await prodCtrl.RecupProduitById(widget.march!.id.toString());
    List<Produit> listTousProduits = prodCtrl.prodById;
    return listTousProduits;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      /*appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        primary: false,
      ),*/
      drawer: DrawerVendeur(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.blueR,
            expandedHeight: 230,
            leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: null /*DrawerAdd()*/),
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.march!.nomEntreprise ?? "",
                maxLines: 2,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              background: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image.network(
                    "${ApiUrl.baseUrl}/${widget.march?.image}",
                    width: double.infinity,
                    height: size.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                  Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.3,
                      color: Colors.black,
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      widget.march!.nomEntreprise ?? "",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),*/
                ],
              ),
            ),
            actions: [
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => InfoVendeur(march: widget.march)));
                    },
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Center(
                  child: Badge(
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
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => Panier()));
                        },
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          size: 30,
                        )),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Center(
                        child: Column(children: [
                      Container(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        height: size.height / 15,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /*Text(
                                  "statut: ",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.ecrit,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),*/
                                widget.march!.disponibilite == "1"
                                    ? Text(
                                        "Fermer",
                                        style: GoogleFonts.poppins(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      )
                                    : Text(
                                        "Ouvert",
                                        style: GoogleFonts.poppins(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Livraison",
                                      style: GoogleFonts.poppins(
                                          color: AppColors.ecrit,
                                          fontSize: 13,
                                          //backgroundColor: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "/",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 13,
                                          //backgroundColor: Colors.blueAccent,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "Ramasser",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 13,
                                          //backgroundColor: Colors.blueAccent,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            /*Row(
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
                            ),*/
                            /*Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Telephone: ",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.ecrit,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "${widget.march!.numeroEntreprise}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.blue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),*/
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "NOS PRODUITS",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: AppColors.ecrit,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder(
                          future: recuperationListProd(),
                          builder: (context, snapshot) {
                            List<Produit>? prod =
                                snapshot.data as List<Produit>?;
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
                              return Center(child: Text("Aucun produit"));
                            }
                          }),
                    ])),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    /*Scaffold(
      appBar: AppBar(
        title: Text("${widget.march?.nomEntreprise}",
            style: TextStyle(color: AppColors.ecrit)),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
        actions: [
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
      ),*/
    //drawer: DrawerAdd(),
    /*body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  "${ApiUrl.baseUrl}/${widget.march?.image}",
                  width: double.infinity,
                  height: size.height * 0.3,
                  fit: BoxFit.cover,
                ),
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.3,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Text(
                    widget.march!.nomEntreprise ?? "",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            Container(
              child: Center(
                  child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  height: size.height / 10,
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
                            "statut: ",
                            style: GoogleFonts.poppins(
                                color: AppColors.ecrit,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                          widget.march!.disponibilite == "1"
                              ? Text(
                                  "Fermer",
                                  style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                )
                              : Text(
                                  "Ouvert",
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
                            "Ouverture: ",
                            style: GoogleFonts.poppins(
                                color: AppColors.ecrit,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${widget.march!.ouverture}",
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
                            "Fermeture: ",
                            style: GoogleFonts.poppins(
                                color: AppColors.ecrit,
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NOS PRODUITS",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: AppColors.ecrit,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                    future: recuperationListProd(),
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
                        return Center(child: Text("Aucun produit"));
                      }
                    }),
              ])),
            ),
          ],
        ),
      ),
    );*/
  }
}





/*

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
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

import '../app/endPoint.dart';
import '../model/category.dart';
import '../model/produit.dart';
import '../widgets/category_card.dart';
import '../widgets/circle_button.dart';
import '../widgets/drawerMarchand.dart';
import '../widgets/search_testfield.dart';

class Vendeur extends StatefulWidget {
  Marchand? march;
  Vendeur({Key? key, this.march}) : super(key: key);

  @override
  State<Vendeur> createState() => _VendeurState();
}

class _VendeurState extends State<Vendeur> {
  List<Produit> listProduits = [];
  late Marchand unMarchand;
  late Stream<List<Produit>> listP;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("objet passer en parametre ---------");
    print(widget.march);
    print(widget.march!.id);
    print(widget.march!.nomEntreprise);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      utilitaire.lancerChargementDialog4(context);
      var prodCtrl = context.read<ProduitController>();
      await prodCtrl.RecupProduitById(widget.march!.id.toString());
      listProduits = prodCtrl.prodById;
      print("----------- les produits par marchant ----------");
      print(listProduits);
      print("------ fin list des produits marchant ------");
      await Future.delayed(Duration(milliseconds: 800));
      // quitter la boite de dialogue de chargement
      Navigator.pop(context);
      setState(() {});
    });
  }

  Future<List<Produit>> recuperationListProd() async {
    var prodCtrl = context.read<ProduitController>();
    await prodCtrl.RecupProduitById(widget.march!.id.toString());
    List<Produit> listTousProduits = prodCtrl.prodById;
    return listTousProduits;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  "${ApiUrl.baseUrl}/${widget.march?.image}",
                  width: double.infinity,
                  height: size.height * 0.3,
                  fit: BoxFit.cover,
                ),
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.3,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Text(
                    widget.march!.nomEntreprise ?? "",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            Container(
              child: Center(
                  child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  height: size.height / 10,
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
                            "statut: ",
                            style: GoogleFonts.poppins(
                                color: AppColors.ecrit,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                          widget.march!.disponibilite == "1"
                              ? Text(
                                  "Fermer",
                                  style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                )
                              : Text(
                                  "Ouvert",
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
                            "Ouverture: ",
                            style: GoogleFonts.poppins(
                                color: AppColors.ecrit,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${widget.march!.ouverture}",
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
                            "Fermeture: ",
                            style: GoogleFonts.poppins(
                                color: AppColors.ecrit,
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NOS PRODUITS",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: AppColors.ecrit,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                    future: recuperationListProd(),
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
                        return Center(child: Text("Aucun produit"));
                      }
                    }),
                /*FutureBuilder(
                    future: recuperationListProd(),
                    builder: (context, snapshot) {
                      List<Produit>? prod = snapshot.data as List<Produit>?;
                      print("Le type de valeur dans vendeur");
                      print(prod.runtimeType);
                      if (snapshot.hasData) {
                        return ListView.builder(
                          //scrollDirection: Axis.horizontal,
                          //shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: listProduits.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ProduitCard(
                              prod: listProduits[index],
                            );
                          },
                        );
                      } else {
                        return Center(child: Text("Aucun produit"));
                      }
                    }),*/
                /*SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NOS PRODUITS",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: AppColors.ecrit,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
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
                FutureBuilder(
                    future: recuperationListProd(),
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
                        return Center(child: Text("Aucun produit"));
                      }
                    }),
              */
              ])),
            ),
          ],
        ),
      ),
    );
  }
}



 */