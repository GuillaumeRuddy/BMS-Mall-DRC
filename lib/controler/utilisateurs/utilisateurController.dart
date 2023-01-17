import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_drc/app/endPoint.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:http/http.dart' as http;
import 'package:mall_drc/model/utilisateur.dart';

class UtilisateurController with ChangeNotifier {
  GetStorage stockage = GetStorage();
  List<Utilisateur> infoUser = [];
  List<Utilisateur> infoUserMAJ = [];

  ecritureStockage(Utilisateur utilisateur) {
    stockage.write('user', utilisateur);
  }

  List lectureStockage() {
    var data_local = stockage.read('user');
    if (data_local != null) {
      List stockage_data = json.decode(data_local);
      return stockage_data;
    }
    return [];
  }

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
      return {"msg": "Erreur inattendue", "status": false};
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
      print('Le Statusss est: **** ${reponse.statusCode}');
      Map<String, dynamic> body = json.decode(reponse.body);
      print(body);
      print('ici la conversion de saauvegarde ++++++++++');
      Utilisateur user = Utilisateur.fromJson(body);
      print('ici le body de saauvegarde ++++++++++');
      print(user);
      print(user.nom);
      print(user.telephone);
      print('fin ici le body de saauvegarde ++++++++++');
      //infoUser.add(body.map((e) => Utilisateur(e)))
      //ecritureStockage(user);
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
      return {"msg": "${stack}", "status": false};
      /*return {"msg": "Erreur inattendue", "status": false};*/
    }
  }

  MajProfile(Map client) async {
    Dio dio = Dio();
    var url = Uri.parse(ApiUrl().majProfile);
    print(url);
    try {
      String data = json.encode(client);
      print(data);
      var retPhoto = await dio.post(
        ApiUrl().majProfile,
      );
      var reponse =
          await http.post(url, headers: utilitaire.header, body: data);
      print('Le Statusss maj *** est: **** ${reponse.statusCode}');
      Map<String, dynamic> body = json.decode(reponse.body);
      print(body);
      Utilisateur user = Utilisateur.fromJson(body);
      var msg = "";
      if (reponse.statusCode == 200) {
        msg = body["msg"];
        ;
      } else {
        msg = "echec de la mise à jour du profile";
        ;
      }
      Map retour = {"msg": msg, "status": reponse.statusCode == 200};
      return retour;
    } catch (e, stack) {
      print(e);
      print("Détail problème connexion ${stack}");
      return {"msg": "${stack}", "status": false};
      /*return {"msg": "Erreur inattendue", "status": false};*/
    }
  }

  MajPhotoProfile(Map photoClient) async {
    var url = Uri.parse(ApiUrl().majPhotoProfile);
    print(url);
    try {
      //seconde Méthode
      /*var request = http.MultipartRequest("Post", url);
      request.fields["id"] = photoClient["id"];
      var pic =
          await http.MultipartFile.fromPath("image", photoClient["image"]);
      request.files.add(pic);
      var rep = await request.send();
      if (rep.statusCode == 200) {
        print("image uploader avec succès");
      } else {
        print("image n'a pas pus être uploader");
      }*/

      String data = json.encode(photoClient);
      print(data);
      var reponse =
          await http.post(url, headers: utilitaire.header, body: data);
      print('Le Statusss majPhoto *** est: **** ${reponse.statusCode}');
      Map<String, dynamic> body = json.decode(reponse.body);
      print(body);
      //Utilisateur user = Utilisateur.fromJson(body);
      var msg = "";
      if (reponse.statusCode == 200) {
        msg = "MAj photo reussit";
      } else {
        msg = "Echec de la MAJ photo";
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
      return {"msg": "${stack}", "status": false};
      /*return {"msg": "Erreur inattendue", "status": false};*/
    }
  }
}
