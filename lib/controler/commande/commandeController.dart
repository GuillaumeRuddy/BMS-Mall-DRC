import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/model/commande.dart';
import 'package:mall_drc/model/driver.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/endPoint.dart';
import '../../db/db_mall.dart';
import 'package:http/http.dart' as http;

class CommandeController with ChangeNotifier {
  List<Commande> listCommande = [];
  int nombre = 0;
  int get nbrPRoduit => nombre;
  Driver ListDriver = new Driver();

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
      Map retour = {
        "msg": msg,
        "status": reponse.statusCode == 200,
        "reponseCmd": body
      };
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
    var url = Uri.parse(
        "https://malldrc.mithap.org/api/mall/v1/paiement/MobileMoney");
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
      } else {
        msg = "Failled";
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
      return {"msg": "Erreur inattendue"};
    }
  }

  PayementUniPesa(Map lignePayement) async {
    var url = Uri.parse(
        "https://api.unipesa.tech/cdef8cc9c5128f655c4f919d2a67b57eddf68764/payment_c2b");
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
      } else {
        msg = "Failled";
      }
      Map retour = {
        "msg": msg,
        "status": body["status"],
        "etat": reponse.statusCode == 200
      };
      return retour;
    } catch (e, stack) {
      print(e);
      //print("******* Détails probleme : ${stack}");
      return {"msg": "Erreur inattendue"};
    }
  }

  recupDriver(String idUser) async {
    print(
        " *********************** ce que je prend dans le manager comme id driver : ${idUser}");
    var url = Uri.parse(
        "https://malldrc.mithap.org/api/mall/v1/localisation/${idUser}/d033e22ae348aeb5660fc2140aec35850c4da997");
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
      Map<String, dynamic> bodyList;
      if (reponse.statusCode == 200) {
        bodyList = json.decode(reponse.body);
        print(bodyList);
        ListDriver = Driver.fromJson(bodyList);
        msg = "";
      } else {
        msg = body["msg"];
      }
      Map retour = {
        "msg": msg,
        "status": reponse.statusCode == 200,
      };
      return retour;
    } catch (e, stack) {
      print(e);
      //print("******* Détails probleme : ${stack}");
      return {"msg": "Erreur inattendue", "status": false};
    }
  }

  recupMoiMeme(String idCmd) async {
    var url = Uri.parse(
        "https://malldrc.mithap.org/api/mall/v1/Successcommande/${idCmd}/d033e22ae348aeb5660fc2140aec35850c4da997");
    print("----- Mon URL est: $url ----");
    try {
      print("debut try");
      var reponse = await http.get(url, headers: utilitaire.header);
      print('Le Status est: **** ${reponse.statusCode}');
      print(reponse.body);
      var body = json.decode(reponse.body);
      print('******* le body du paiement *********');
      print(body);
      var msg = "";
      if (reponse.statusCode == 200) {
        msg = body['msg'];
      } else {
        msg = body['msg'];
      }
      Map retour = {"msg": msg, "status": reponse.statusCode == 200};
      return retour;
    } catch (e, stack) {
      print(e);
      //print("******* Détails probleme : ${stack}");
      return {"msg": "Erreur inattendue"};
    }
  }
}
