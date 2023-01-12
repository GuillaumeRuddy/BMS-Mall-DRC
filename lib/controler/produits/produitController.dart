import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mall_drc/app/endPoint.dart';
import 'package:http/http.dart' as http;
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/model/produit.dart';

class ProduitController with ChangeNotifier {
  List<Produit> prod = [];
  List<Produit> prodById = [];
  List<Produit> prodLimit = [];
  List<Produit> prodRecherche = [];
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
    var url = Uri.parse(
        "https://malldrc.mithap.org/api/mall/v1/produits/marchand/${idMarch}/d033e22ae348aeb5660fc2140aec35850c4da997");
    print(url);
    try {
      print("debut try");
      String data = json.encode(idMarch);
      print(data);
      var reponse = await http.get(url, headers: utilitaire.header);
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

  RecupProduitLimit(String nombre) async {
    var url = Uri.parse(
        "https://malldrc.mithap.org/api/mall/v1/produit/take/${nombre}");
    print(url);
    try {
      print("debut try");
      String data = json.encode(nombre);
      print(data);
      var reponse = await http.get(url, headers: utilitaire.header);
      print('Le Status est: **** ${reponse.statusCode}');
      print(reponse.body);
      var body = json.decode(reponse.body);
      print('******* le body de produit ilimite *********');
      print(body);
      print(
          '******* ------- fin du body de produit ilimite -------- *********');
      var msg = "";
      List bodyList = [];
      if (reponse.statusCode == 200) {
        bodyList = json.decode(reponse.body);
        print(bodyList);
        prodLimit = bodyList.map((e) => Produit.fromJson(e)).toList();
        print(prodLimit.runtimeType);
      } else {
        msg = body["msg"];
      }
      return {"msg": msg, "status": reponse.statusCode == 200};
    } catch (e, stack) {
      print(e);
      print("******* Détails probleme : ${stack}");
    }
  }

  RechercheProduit(String nomProd) async {
    var url = Uri.parse(
        "https://malldrc.mithap.org/api/mall/v1/produit/recherche/${nomProd}");
    print(url);
    try {
      print("debut try");
      String data = json.encode(nomProd);
      print(data);
      var reponse = await http.get(url, headers: utilitaire.header);
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
        prodRecherche = bodyList.map((e) => Produit.fromJson(e)).toList();
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
