import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_drc/controler/adresse/adresseController.dart';
import 'package:mall_drc/controler/commande/commandeController.dart';
import 'package:mall_drc/controler/marchants/marchandController.dart';
import 'package:mall_drc/controler/panier/panierController.dart';
import 'package:mall_drc/controler/produits/produitController.dart';
import 'package:mall_drc/controler/utilisateurs/utilisateurController.dart';
import 'package:mall_drc/pages/demarage.dart';
import 'package:provider/provider.dart';

import 'controler/categorie/categorieController.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UtilisateurController()),
        ChangeNotifierProvider(create: (_) => ProduitController()),
        ChangeNotifierProvider(create: (_) => PanierController()),
        ChangeNotifierProvider(create: (_) => CommandeController()),
        ChangeNotifierProvider(create: (_) => MarchandController()),
        ChangeNotifierProvider(create: (_) => CategorieController()),
        ChangeNotifierProvider(create: (_) => adresseController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mall DRC',
        /*theme: ThemeData(
          primarySwatch: Colors.transparent,
        ),*/
        home: Demarage(timing: 5),
      ),
    );
  }
}
