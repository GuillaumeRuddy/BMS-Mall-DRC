import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/model/marchant.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../app/endPoint.dart';

class MarchandController with ChangeNotifier {
  List<Marchand> listDesMarchands = [];

  RecupMarchand(String categ) async {
    var url = Uri.parse(
        "https://malldrc.mithap.org/api/mall/v1/marchand/filtre/${categ}/033e22ae348aeb5660fc2140aec35850c4da997");
    print(url);
    try {
      print("debut try");
      String data = json.encode(categ);
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
        List bodyList = [];
        bodyList = json.decode(reponse.body);
        print(bodyList);

        listDesMarchands = bodyList.map((e) => Marchand.fromJson(e)).toList();
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
