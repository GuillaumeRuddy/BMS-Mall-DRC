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
      return {"msg": "Erreur inattendue", "status": "false"};
    }
  }

  //Methode pour se connecter à l'application
  Connexion(Map client) async {
    var url = Uri.parse(ApiUrl().connexion);
    print(url);
    try {
      String data = json.encode(client);
      print(data);
      var reponse =
          await http.post(url, headers: utilitaire.header, body: data);
      print('Le Status est: **** ${reponse.statusCode}');
      Map body = json.decode(reponse.body);
      print(body);
      var msg = "";
      if (reponse.statusCode == 200) {
        msg = "Connecter";
      } else {
        msg = "email ou mot de passe incorrect";
      }
      Map retour = {
        "msg": msg,
        "status": reponse.statusCode == 200,
        "utilisateur": body
      };
      return retour;
    } catch (e, stack) {
      print(e);
      print("Détail problème connexion ${stack}");
      return {"msg": "Erreur inattendue", "status": "false"};
    }
  }
}
