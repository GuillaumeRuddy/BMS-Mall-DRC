import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mall_drc/app/endPoint.dart';
import 'package:http/http.dart' as http;
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/model/produit.dart';

class ProduitController with ChangeNotifier {
  List<Produit> prod = [];
  // Methode pour recuper les produits
  RecupProduit() async {
    var url = Uri.parse(ApiUrl().produit);
    try {
      var reponse = await http.get(url, headers: utilitaire.header);
      print(reponse.body);
      List bodyList = [];
      if (reponse.statusCode == 200) {
        bodyList = json.decode(reponse.body);
        prod = bodyList.map((e) => Produit.fromJson(e)).toList();
      }
      return {"body": bodyList, "status": reponse.statusCode == 200};
    } catch (e, stack) {
      print(e);
      print("******* Détails probleme : ${stack}");
    }
  }
}
