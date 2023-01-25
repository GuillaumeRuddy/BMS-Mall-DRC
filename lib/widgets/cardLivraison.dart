import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/model/commande.dart';
import 'package:mall_drc/pages/adresse.dart';
import 'package:mall_drc/pages/checkout.dart';
import 'package:mall_drc/pages/coordoner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/detailsCmd.dart';

class CardLivraison extends StatelessWidget {
  Commande? cmd;
  CardLivraison({super.key, this.cmd});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DetailsCmd(
                  livraison: (cmd!.aretirer == "oui") ? true : false,
                  cmde: cmd,
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
                  Row(
                    children: [
                      Text(
                        "Ref: ",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      Text(
                        cmd!.reference ?? "",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.ecrit),
                      ),
                    ],
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
              //const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    "Adresse: ",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  Text(
                    cmd!.adresse ?? "",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Statut: ",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  Text(
                    cmd!.statut ?? "",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
