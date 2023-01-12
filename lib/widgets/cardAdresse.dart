import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/adresse.dart';
import 'package:mall_drc/pages/checkout.dart';
import 'package:mall_drc/pages/coordoner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardAdresse extends StatelessWidget {
  String? nom;
  String? adresse;
  String? description;
  CardAdresse({super.key, this.nom, this.adresse, this.description});

  void enregsitrerAdrSelect() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("nomAdresseSelec", nom!);
    await pref.setString("coordAdresseSelec", adresse!);
    await pref.setString("descSelec", description!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        enregsitrerAdrSelect();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => CheckoutPage(
                  livraison: true,
                )));
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nom ?? "",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600, color: AppColors.ecrit),
                  ),
                  /*InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => MesAdresses()));
                    },
                    child: Text(
                      'Changer',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: Colors.redAccent,
                          ),
                    ),
                  ),*/
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                adresse ?? "",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                description ?? "",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
