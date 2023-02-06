import 'package:flutter/material.dart';
import 'package:mall_drc/controler/livraison/livraisoncontroller.dart';
import 'package:mall_drc/model/livraison.dart';
import 'package:mall_drc/pages/echecLivraison.dart';
import 'package:mall_drc/widgets/cardLivraison.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MesLivraisons extends StatefulWidget {
  const MesLivraisons({Key? key}) : super(key: key);

  @override
  State<MesLivraisons> createState() => _MessageState();
}

class _MessageState extends State<MesLivraisons> {
  List<Livraison> listCommande = [];
  String? idUse;
  Livraison? lvr;

  recupLivraison() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idUse = pref.getInt("id").toString();
    var cmdCtrl = context.read<LivraisonController>();
    await cmdCtrl.RecupLivraionsById(idUse!);
    var listCommande = cmdCtrl.listLivraison;
    return listCommande;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: recupLivraison(),
          builder: (context, snapshot) {
            List<Livraison>? user = snapshot.data as List<Livraison>?;
            print("Le type de valeur dans Livraison");
            print(user.runtimeType);
            if (snapshot.hasData) {
              if (user!.isEmpty) {
                return echecLivr();
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: user.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardLivraison(lvrsn: user[index]);
                        },
                      )
                    ],
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
