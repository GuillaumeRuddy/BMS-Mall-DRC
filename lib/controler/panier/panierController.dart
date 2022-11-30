import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/db_mall.dart';
import '../../model/produit.dart';

class PanierController extends ChangeNotifier {
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

  /*Future<int> getNbrItemPanier(String id) async {
    return nombre = await dbMAll!.getNbrListPanier(id) as int;
  }*/

  /*Future<int> supprimerProduit(int id) async {
    int retour = await dbMAll!.suppressionProduitPanier(id);
    print("----- le retour du panier -----");
    print(retour);
    print("----- fin du retour du panier -----");
    return retour;
  }*/

  void setItemPanier() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("nbrProduit", nombre);
    pref.setDouble("totalPrix", prixTotal);
    notifyListeners();
  }

  void reinitialiserItemPanier() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("totalPrix", 0.0);
    notifyListeners();
  }

  void getItemPanier() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nombre = pref.getInt("nbrProduit") ?? 0;
    prixTotal = pref.getDouble("totalPrix") ?? 0.0;
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
    prixTotal -= prixAjouter;
    setItemPanier();
    notifyListeners();
  }

  double getPrixTotal() {
    getItemPanier();
    return prixTotal;
  }
}
