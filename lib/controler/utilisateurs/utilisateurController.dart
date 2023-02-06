import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
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

  /*Future loger(String login, String pass) async {
    print("mon user ************ " + login);
    print("mon mot de passe ************ " + pass);
    //Debut Test de connection, pour voir si l'utilisateur est connecter
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(" ******  Nous sommes dans le check internet   ****** ");
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      //S'il est connecter on vas vers l'API ici...
      setState(() {
        _loading = true;
      });
      try {
        print(" ******  debut try   ****** ");
        final response = await http
            .post(
                Uri.parse(
                    "http://parentseleves-rdc.org/zando/public/api/loginapi"),
                headers: <String, String>{
                  "Content-type": "application/json; chartset=UTF-8"
                },
                body: jsonEncode(
                    <String, String>{"username": login, "password": pass}))
            .timeout(const Duration(seconds: 20), onTimeout: () {
          //<----Gestion du time out dans le cas ou sa prend trop de temps
          print(" ******  tozo zela  ****** ");
          snackBar("Delais d'attente depasser, veuillez reessaie plus tard");
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        });
        print(" ******  response  ****** ");
        if (response.statusCode == 200) {
          print(" ******  200  ****** ");
          //<------ Teste si la requette vers l'API marche
          var data = jsonDecode(response
              .body); //<---- recuperation des données qui sont en format JSON
          print("les datas que recupere *********** " + data.toString());

          var retour = data["status"];
          if (retour == "success") {
            print(data["donnees"]["id"]);
            idUser = data["donnees"]["id"];

            // enregistrement des élements de l'utilisateur comme valeur de session qui sera repris dans les différents écrans
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString("user", login);
            pref.setString("id_user", idUser.toString());
            pref.setString("mdp", pass);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Home(userName: login, idUser: idUser.toString())));

            /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Acceuil(userName: login, idUser: idUser.toString())));*/

            setState(() {
              toast("Connecter");
              bool _loading = false;
            });
          } else {
            var msg = "Le nom utilisateur ou mot de passe est incorrecte";
            setState(() {
              snackBar(msg);
            });
          }

          //ici tu met la redirection en fonction de l'action qui vas suivre...
        } else {
          print("la reponse du status est éééééééééé ");
          print(response.statusCode);
          setState(() {
            bool _loading = false;
            var msg = "vérification impossible";
            snackBar(msg);
          });
        }
      } on SocketException {
        setState(() {
          snackBar(
              "Nous rencontrons un problème, veuillez réessaie ulterieuement");
        });
      } on TimeoutException {
        setState(() {
          snackBar("Delais d'attente dépasser");
        });
      } catch (e) {
        print("erreur: $e");
        setState(() {
          snackBar("Nous rencontrons un problème $e");
        });
      }
    } else {
      setState(() {
        toast("Impossible de se connecter à internet");
      });
    }
  }*/

  //Methode pour se connecter à l'application
  Connexion(Map client) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var url = Uri.parse(ApiUrl().connexion);
      print(url);
      try {
        String data = json.encode(client);
        print(data);
        var reponse = await http
            .post(url, headers: utilitaire.header, body: data)
            .timeout(const Duration(seconds: 30), onTimeout: () {
          print(" ******  tozo zela  ****** ");
          utilitaire.toast("temps dépasser");
          throw TimeoutException(
              'Sa pris trop de temps, veuillez réessaie ultérieurement!');
        });
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
      } /*on SocketException {
        return {
          "msg": "Connection avec le serveur impossible",
          "status": false
        };
      }*/
      on TimeoutException {
        return {
          "msg": "delait dattente dépaser, veuillez réessaie ultérieurement!",
          "status": false
        };
      } catch (e, stack) {
        print(e);
        print("Détail problème connexion ${stack}");
        //return {"msg": "${stack}", "status": false};
        return {"msg": "Erreur inattendue", "status": false};
      }
    } else {
      return {"msg": "Vous n'êtes pas connecter à internet", "status": false};
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
    print(" ****** Ce que j'envoie comme donnée d'image: ${photoClient}");
    print(url);
    try {
      //seconde Méthode
      var request = http.MultipartRequest("Post", url);
      print("-------- La requette 1: ${request}");
      request.fields["id"] = photoClient["id"].toString();
      request.headers["Authorization"] = "";
      var pic = await http.MultipartFile.fromPath(
          "image", photoClient["image"].toString());
      print("La photo après conversion multipart: ${pic}");
      request.files.add(pic);
      var rep = await request.send();
      print("+++++++++++++++ le retour de la requette envoie: ${rep}");
      print(rep.runtimeType);
      var msg = "";
      if (rep.statusCode == 200) {
        print("image uploader avec succès");
        msg = "image uploader avec succès";
      } else {
        print("image n'a pas pus être uploader");
        msg = "image n'a pas pus être uploader";
      }

      /*String data = json.encode(photoClient);
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
      }*/
      //Map retour = {"msg": msg, "status": reponse.statusCode == 200};
      Map retour = {"msg": msg, "status": rep.statusCode == 200};
      return retour;
    } catch (e, stack) {
      print(e);
      print("Détail problème connexion ${stack}");
      return {"msg": "${stack}", "status": false};
      /*return {"msg": "Erreur inattendue", "status": false};*/
    }
  }
}
