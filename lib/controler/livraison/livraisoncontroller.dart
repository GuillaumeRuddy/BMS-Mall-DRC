import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/model/livraison.dart';
import 'package:mall_drc/pages/livraison.dart';

import '../../app/endPoint.dart';

class LivraisonController with ChangeNotifier {
  List<Livraison> listLivraison = [];
  LancerLivraison(Map maLivraison) async {
    var url = Uri.parse(ApiUrl().livraison);
    print("----- Mon URL est: $url ----");
    try {
      print("debut try");
      String data = json.encode(maLivraison);
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
      Map retour = {
        "msg": msg,
        "status": reponse.statusCode == 200,
        "body": body
      };
      return retour;
    } catch (e, stack) {
      print(e);
      //print("******* Détails probleme : ${stack}");
      return {"msg": "Erreur inattendue", "status": false};
    }
  }

  RecupLivraionsById(String idUser) async {
    var url = Uri.parse(
        "${ApiUrl.baseUrl}/api/mall/v1/livraison/recuperation/${idUser}/${ApiUrl.token}");
    print("----- Mon URL est: $url ----");
    try {
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
        listLivraison = bodyList.map((e) => Livraison.fromJson(e)).toList();
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
}
