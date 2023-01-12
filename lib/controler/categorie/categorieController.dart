import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/endPoint.dart';

import 'package:http/http.dart' as http;
import 'package:mall_drc/pages/categories.dart';

import '../../model/categorie.dart';

class CategorieController with ChangeNotifier {
  List<Categorie> listDesCategorie = [];
  RecupCategorie() async {
    var url = Uri.parse(ApiUrl().categorie);
    print(url);
    try {
      var reponse = await http.get(url, headers: utilitaire.header);
      print(reponse.body);
      List bodyList = [];
      if (reponse.statusCode == 200) {
        bodyList = json.decode(reponse.body);
        print(bodyList);

        listDesCategorie = bodyList.map((e) => Categorie.fromJson(e)).toList();
      }
      return {"body": listDesCategorie, "status": reponse.statusCode == 200};
    } catch (e, stack) {
      print(e);
      print("******* Détails probleme : ${stack}");
    }
  }
}
