import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PanierController extends ChangeNotifier {
  int nombre = 0;
  int get nbrPRoduit => nombre;

  double prixTotal = 0.0;
  double get prixTot => prixTotal;

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
