import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/model/commande.dart';
import 'package:mall_drc/widgets/cardCommande.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controler/commande/commandeController.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  List<Commande> listCommande = [];
  String? idUse;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mes commandes",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
      ),
      body: FutureBuilder(
          future: recupCommande(),
          builder: (context, snapshot) {
            List<Commande>? user = snapshot.data as List<Commande>?;
            print("Le type de valeur dans Commande");
            print(user.runtimeType);
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: user!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardCommande(
                            ref: user[index].reference,
                            adresse: user[index].adresse,
                            statut: user[index].statut);
                      },
                    )
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
