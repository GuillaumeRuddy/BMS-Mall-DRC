import 'package:flutter/cupertino.dart';
import 'package:mall_drc/model/adresse.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/db_mall.dart';

class adresseController with ChangeNotifier {
  DbMAll? dbMAll = DbMAll();

  late Future<List<Adresse>> adresses;
  Future<List<Adresse>> get ListAdresse => adresses;

  Future<List<Adresse>> getDataAdresse() async {
    adresses = dbMAll!.getListAdresse();
    print("----- le retour du panier pour les adresses -----");
    print(adresses.runtimeType);
    print(adresses);
    print("----- fin du retour du panier pour les adresses -----");
    return adresses;
  }

  void supressionAdresse(String id) async {
    String reponse = "";
    reponse = await dbMAll!.suppressionAdresse(id);
    print("Adresse supprimer avec succes");
    notifyListeners();
  }

  void ajoutAdresse(Adresse uneAdresse) async {
    String reponse = "";
    reponse = (await dbMAll!.InsertionAdresse(uneAdresse)) as String;
    print("Adresse ajouter avec succes");
    notifyListeners();
  }

  void setDefault(String nom, String adresse, String description) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    pref.setString("nomAdresse", nom);
    pref.setString("adresse", adresse);
    pref.setString("description", description);
    notifyListeners();
  }
}
