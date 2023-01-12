import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/model/commande.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/endPoint.dart';
import '../../db/db_mall.dart';
import 'package:http/http.dart' as http;

class CommandeController with ChangeNotifier {
  List<Commande> listCommande = [];
  int nombre = 0;
  int get nbrPRoduit => nombre;

  CommandeProduit(Map ligneProd) async {
    var url = Uri.parse(ApiUrl().commande);
    print("----- Mon URL est: $url ----");
    try {
      print("debut try");
      String data = json.encode(ligneProd);
      print(data);
      var reponse =
          await http.post(url, headers: utilitaire.header, body: data);
      print('Le Status est: **** ${reponse.statusCode}');
      print(reponse.body);
      var body = json.decode(reponse.body);
      print('******* le body *********');
      print(body);
      var msg = "";
      if (reponse.statusCode == 200) {
        msg = body["msg"];
        print("***** Quand cest valide *****");
        print(msg);
      } else {
        msg = body["msg"];
      }
      Map retour = {"msg": msg, "status": reponse.statusCode == 200};
      return retour;
    } catch (e, stack) {
      print(e);
      //print("******* Détails probleme : ${stack}");
      return {"msg": "Erreur inattendue", "status": false};
    }
  }

  CommandeByUser(String idUser) async {
    var url = Uri.parse(
        "https://malldrc.mithap.org/api/mall/v1/getcommande/${idUser}/d033e22ae348aeb5660fc2140aec35850c4da997");
    print("----- Mon URL est: $url ----");
    try {
      print("debut try");
      var reponse = await http.get(url, headers: utilitaire.header);
      print('Le Status est: **** ${reponse.statusCode}');
      print(reponse.body);
      var body = json.decode(reponse.body);
      print('******* le body de commande recuperer *********');
      print(body);
      var msg = "";
      List bodyList = [];
      if (reponse.statusCode == 200) {
        bodyList = json.decode(reponse.body);
        print(bodyList);
        listCommande = bodyList.map((e) => Commande.fromJson(e)).toList();
      } else {
        msg = body["msg"];
      }
      Map retour = {"msg": msg, "status": reponse.statusCode == 200};
      return retour;
    } catch (e, stack) {
      print(e);
      //print("******* Détails probleme : ${stack}");
      return {"msg": "Erreur inattendue", "status": false};
    }
  }

  Future<int> recupNombreCmd() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUse = await pref.getInt("id").toString();
    await CommandeByUser(idUse);
    nombre = listCommande.length;
    return nombre;
  }

  Payement(Map lignePayement) async {
    var url =
        Uri.parse("https://malldrc.mithap.org/api/mall/v1/paiement/airtel");
    print("----- Mon URL est: $url ----");
    try {
      print("debut try");
      String data = json.encode(lignePayement);
      print(data);
      var reponse =
          await http.post(url, headers: utilitaire.header, body: data);
      print('Le Status est: **** ${reponse.statusCode}');
      print(reponse.body);
      var body = json.decode(reponse.body);
      print('******* le body du paiement *********');
      print(body);
      var msg = "";
      if (reponse.statusCode == 200) {
        msg = "Succed";
        print("***** Quand c'est valide *****");
        print(msg);
      } else {
        msg = "Failled";
      }
      return msg;
    } catch (e, stack) {
      print(e);
      //print("******* Détails probleme : ${stack}");
      return {"msg": "Erreur inattendue"};
    }
  }
}
