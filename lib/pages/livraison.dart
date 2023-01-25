import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/controler/livraison/livraisoncontroller.dart';
import 'package:mall_drc/pages/success.dart';
import 'package:mall_drc/pages/successLivraison.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/app_constatns.dart';

class Livraison extends StatefulWidget {
  const Livraison({super.key});

  @override
  State<Livraison> createState() => _LivraisonState();
}

class _LivraisonState extends State<Livraison> {
  TextEditingController nomExpCtrl = new TextEditingController();
  TextEditingController telExpCtrl = new TextEditingController();
  TextEditingController adrExpCtrl = new TextEditingController();
  TextEditingController detColisCtrl = new TextEditingController();
  TextEditingController lieuColisCtrl = new TextEditingController();
  TextEditingController lieuDestCtrl = new TextEditingController();
  TextEditingController nomDestCtrl = new TextEditingController();
  TextEditingController telDestCtrl = new TextEditingController();
  String? identId;
  Map resultat = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rempliDonne();
  }

  void rempliDonne() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nomExpCtrl.text = pref.getString("nom").toString();
    telExpCtrl.text = pref.getString("telephone").toString();
    identId = pref.getInt("id").toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Livraison",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nomExpCtrl,
                    enabled: false,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nom Expéditeur',
                      hintText: "Saisir le nom de l'expediteur",
                    )),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: telExpCtrl,
                    enabled: false,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telephone Expediteur',
                      hintText: "Saisir le téléphone de l'éxpéditeur",
                    )),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: adrExpCtrl,
                    enabled: true,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Adresse Expéditeur',
                      hintText: "Saisir l'adresse de l'expediteur",
                    )),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: lieuColisCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Emplacement du colis',
                      hintText: "Saisir les détails sur l'emplacement du colis",
                    )),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: detColisCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Détails du colis',
                      hintText: "Saisir les détails du colis",
                    )),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: lieuDestCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Adresse destination',
                      hintText: "Saisir l'adresse de destination",
                    )),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nomDestCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nom destinataire',
                      hintText: "Saisir le nom du destinataire",
                    )),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: telDestCtrl,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Téléphone du destinataire',
                      hintText: "Saisir le téléphone du destinataire",
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    //ce bouton fonctionne uniquement si le numero est valid
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          //Prend la couleur bleu si numero valid sinon grise
                          primary: AppColors.ecrit),
                      onPressed: () {
                        Map alivre = {
                          "id": identId!,
                          "nom": nomExpCtrl.text,
                          "telephone": telExpCtrl.text,
                          "adresse": adrExpCtrl.text,
                          "details": detColisCtrl.text,
                          "emplacement": lieuColisCtrl.text,
                          "adresse_destination": lieuDestCtrl.text,
                          "nom_destinataire": nomDestCtrl.text,
                          "telephone_destination": telDestCtrl.text
                        };
                        /*Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => SuccessLivraison()));*/
                        EnvoiDmd(alivre);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Demander une livraison",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void EnvoiDmd(Map aLivre) async {
    utilitaire.lancerChargementDialog4(context);

    var ctrlLivraison = context.read<LivraisonController>();

    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getInt("id").toString();
    print("Ce que j'envoie comme livraison*********");
    print(aLivre);

    resultat = await ctrlLivraison.LancerLivraison(aLivre);
    print('la livraison a afficher ++++++++++++');
    print(resultat);

    utilitaire.afficherSnack(context, resultat["msg"],
        resultat["status"] ? Colors.green : Colors.red);

    await Future.delayed(Duration(milliseconds: 800));
    Navigator.pop(context, true);

    if (resultat['status']) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => SuccessLivraison()));
    }
  }
}
