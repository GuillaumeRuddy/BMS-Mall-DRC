import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mall_drc/app/appUtil.dart';

import '../../app/endPoint.dart';

class LivraisonController with ChangeNotifier {
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
}
