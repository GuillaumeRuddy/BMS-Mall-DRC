import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/model/commande.dart';
import 'package:mall_drc/pages/echecCommande.dart';
import 'package:mall_drc/widgets/cardCommande.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controler/commande/commandeController.dart';

class MesCommandes extends StatefulWidget {
  const MesCommandes({Key? key}) : super(key: key);

  @override
  State<MesCommandes> createState() => _MessageState();
}

class _MessageState extends State<MesCommandes> {
  List<Commande> listCommande = [];
  String? idUse;
  Commande? cmd;

  recupCommande() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idUse = await pref.getInt("id").toString();
    var cmdCtrl = context.read<CommandeController>();
    await cmdCtrl.CommandeByUser(idUse!);
    var listCommande = cmdCtrl.listCommande;
    return listCommande;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: recupCommande(),
          builder: (context, snapshot) {
            List<Commande>? user = snapshot.data as List<Commande>?;
            print("Le type de valeur dans Commande");
            print(user.runtimeType);
            if (snapshot.hasData) {
              if (user!.isEmpty) {
                return echecCmd();
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: user.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardCommande(cmd: user[index]);
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
