import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mall_drc/app/endPoint.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:http/http.dart' as http;

class UtilisateurController with ChangeNotifier {
  //Methode pour enregistrer un nouveau client
  EnregistrementClient(Map client) async {
    var url = Uri.parse(ApiUrl().enregistrement);
    print("----- Mon URL est: $url ----");
    try {
      print("debut try");
      String data = json.encode(client);
      var reponse =
          await http.post(url, headers: utilitaire.header, body: data);
      print('Le Status est: **** ${reponse.statusCode}');
      Map body = json.decode(reponse.body);
      var msg = "";
      /*if (reponse.statusCode == 200) {
        msg = body["msg"];
      } else {
        msg = body["msg"];
      }*/
      return {"status": reponse.statusCode == 200};
    } catch (e, stack) {
      print(e);
      print("******* Détails probleme : ${stack}");
      return {"msg": "Erreur inattendue", "status": "false"};
    }
  }

  //Methode pour se connecter à l'application
  Connexion(Map client) async {
    var url = Uri.parse(ApiUrl().connexion);
    try {
      String data = json.encode(client);
      var reponse = await http.post(url, body: data);
      print('Le Status est: **** ${reponse.statusCode}');
      Map body = json.decode(reponse.body);
      var msg = "";
      if (reponse.statusCode == 200) {
        msg = body["msg"];
      } else {
        msg = body["msg"];
      }
      return {"msg": msg, "status": reponse.statusCode == 200};
    } catch (e, stack) {
      print(e);
      print("Détail problème connexion ${stack}");
      return {"msg": "Erreur inattendue", "status": "false"};
    }
  }
}
