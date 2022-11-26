import 'package:flutter/material.dart';
import 'package:mall_drc/controler/panier/panierController.dart';
import 'package:mall_drc/controler/produits/produitController.dart';
import 'package:mall_drc/controler/utilisateurs/utilisateurController.dart';
import 'package:mall_drc/pages/demarage.dart';
import 'package:provider/provider.dart';

void main() {
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
        ChangeNotifierProvider(create: (_) => PanierController())
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
