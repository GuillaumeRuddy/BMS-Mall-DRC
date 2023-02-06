import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/pages/listLivraison.dart';
import 'package:mall_drc/pages/list_commande.dart';

import '../app/app_constatns.dart';

class Activite extends StatefulWidget {
  const Activite({super.key});

  @override
  State<Activite> createState() => _NotificationState();
}

class _NotificationState extends State<Activite> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Notification",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
          ),
          elevation: 0.0,
          backgroundColor: AppColors.blueR,
        ),
        body: Column(
          children: [
            TabBar(
                indicatorColor: Colors.blue,
                indicatorWeight: 3.0,
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.local_shipping,
                      color: AppColors.blueR,
                      size: 30,
                    ),
                    text: "Livraison",
                    height: 70,
                  ),
                  Tab(
                    icon: Icon(
                      Icons.list_alt_outlined,
                      color: AppColors.blueR,
                      size: 30,
                    ),
                    text: "Commande",
                    height: 70,
                  )
                ]),
            Expanded(
              child: TabBarView(children: [MesLivraisons(), MesCommandes()]),
            )
          ],
        ),
        /*floatingActionButton: FloatingActionButton(
          onPressed: (() {
            /*Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Coordonne()));*/
          }),
          backgroundColor: AppColors.ecrit,
          tooltip: "Tous supprimer",
          child: Icon(Icons.delete_sweep_rounded),
        ),*/
      ),
    );
  }
}
