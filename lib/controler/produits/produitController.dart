import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mall_drc/app/endPoint.dart';
import 'package:http/http.dart' as http;
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/model/produit.dart';

class ProduitController with ChangeNotifier {
  List<Produit> prod = [];
  List<Produit> prodById = [];
  // Methode pour recuper les produits
  RecupProduit() async {
    var url = Uri.parse(ApiUrl().produits);
    try {
      var reponse = await http.get(url, headers: utilitaire.header);
      print(reponse.body);
      List bodyList = [];
      if (reponse.statusCode == 200) {
        bodyList = json.decode(reponse.body);
        print(bodyList);

        prod = bodyList.map((e) => Produit.fromJson(e)).toList();
      }
      return {"body": prod, "status": reponse.statusCode == 200};
    } catch (e, stack) {
      print(e);
      print("******* Détails probleme : ${stack}");
    }
  }

  RecupProduitById(String idMarch) async {
    var url = Uri.parse(ApiUrl().produitsById);
    try {
      print("debut try");
      String data = json.encode(idMarch);
      print(data);
      var reponse =
          await http.post(url, headers: utilitaire.header, body: data);
      print('Le Status est: **** ${reponse.statusCode}');
      print(reponse.body);
      var body = json.decode(reponse.body);
      print('******* le body *********');
      print(body);
      var msg = "";
      List bodyList = [];
      if (reponse.statusCode == 200) {
        bodyList = json.decode(reponse.body);
        print(bodyList);
        prodById = bodyList.map((e) => Produit.fromJson(e)).toList();
      } else {
        msg = body["msg"];
      }
      return {"msg": msg, "status": reponse.statusCode == 200};
    } catch (e, stack) {
      print(e);
      print("******* Détails probleme : ${stack}");
    }
  }
}
