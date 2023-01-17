import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/db_mall.dart';
import '../../model/produit.dart';

class PanierController with ChangeNotifier {
  DbMAll? dbMAll = DbMAll();

  int nombre = 0;
  int get nbrPRoduit => nombre;

  double prixTotal = 0.0;
  double get prixTot => prixTotal;

  /*late Future<List<Produit>> TousLespPoduitsById;
  Future<List<Produit>> get ListProduitById => TousLespPoduitsById;*/

  late Future<List<Produit>> TousLespPoduits;
  Future<List<Produit>> get ListProduit => TousLespPoduits;

  /*Future<List<Produit>> getData(String id) async {
    TousLespPoduitsById = dbMAll!.getListPanierById(id);
    print("----- le retour du panier -----");
    print(TousLespPoduitsById.runtimeType);
    print(TousLespPoduitsById);
    print("----- fin du retour du panier -----");
    return TousLespPoduitsById;
  }*/

  Future<List<Produit>> getData() async {
    TousLespPoduits = dbMAll!.getListPanier();
    print("----- le retour du panier -----");
    print(TousLespPoduits.runtimeType);
    print(TousLespPoduits);
    print("----- fin du retour du panier -----");
    return TousLespPoduits;
  }

  Future<int> getNbrItemPanier() async {
    return nombre = await dbMAll!.getNbrListPanier() as int;
  }

  void supressionItemPanier(String id) async {
    String reponse = "";
    reponse = await dbMAll!.suppressionProduitPanier(id);
    notifyListeners();
  }

  void setItemPanier() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("nbrProduit", nombre);
    pref.setDouble("totalPrix", prixTotal);
    notifyListeners();
  }

  void getItemPanier() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nombre = pref.getInt("nbrProduit") ?? 0;
    prixTotal = pref.getDouble("totalPrix") ?? 0.0;
    notifyListeners();
  }

  void reinitialiserItemPanier() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("totalPrix", 0.0);
    notifyListeners();
  }

  void reinitAllPanier() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("nbrProduit", 0);
    pref.setDouble("totalPrix", 0.0);
    notifyListeners();
  }

  void ajoutCtrPanier() {
    nombre++;
    setItemPanier();
    notifyListeners();
  }

  void diminuerCtrPanier() {
    nombre--;
    setItemPanier();
    notifyListeners();
  }

  int getCtrPanier() {
    getItemPanier();
    return nombre;
  }

  void ajoutPrixTotal(double prixAjouter) {
    prixTotal += prixAjouter;
    setItemPanier();
    notifyListeners();
  }

  void diminuerPrixTotal(double prixAjouter) {
    print("le prix diminuer venant du panier est de: ${prixAjouter}");
    if (prixTotal > 0) {
      prixTotal -= prixAjouter;
    }
    print(
        "le prix diminuer après calcule et venant du panier est de: ${prixTotal}");
    setItemPanier();
    notifyListeners();
  }

  double getPrixTotal() {
    getItemPanier();
    return prixTotal;
  }
}
