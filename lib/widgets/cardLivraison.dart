import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/model/livraison.dart';
import 'package:mall_drc/pages/detailsLivraison.dart';

import '../pages/detailsCmd.dart';

class CardLivraison extends StatelessWidget {
  Livraison? lvrsn;
  CardLivraison({super.key, this.lvrsn});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DetailsLivraison(
                  livrsn: lvrsn,
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
                        lvrsn!.reference ?? "",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.ecrit),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Adresse: ",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  Text(
                    lvrsn!.adresse ?? "",
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
                    lvrsn!.statut ?? "",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: (lvrsn!.statut! == "livré")
                            ? Colors.green
                            : (lvrsn!.statut! == "en cours")
                                ? Colors.blue
                                : Colors.red),
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
