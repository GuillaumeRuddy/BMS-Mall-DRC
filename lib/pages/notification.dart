import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/controler/livraison/livraisoncontroller.dart';
import 'package:mall_drc/pages/listLivraison.dart';
import 'package:mall_drc/pages/list_commande.dart';
import 'package:provider/provider.dart';

import '../app/app_constatns.dart';
import '../controler/commande/commandeController.dart';

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
                    icon: /*Icon(
                      Icons.local_shipping,
                      color: AppColors.blueR,
                      size: 30,
                    ),*/
                        Badge(
                            badgeColor: Colors.red,
                            padding: EdgeInsets.all(5),
                            position: BadgePosition.bottomEnd(),
                            badgeContent: Consumer<LivraisonController>(
                              builder: ((context, value, child) {
                                return FutureBuilder(
                                    future: value.recupNombreLivr(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<int> snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data.toString(),
                                          style: TextStyle(
                                            fontSize: snapshot.data
                                                        .toString()
                                                        .length <
                                                    2
                                                ? 12
                                                : 9,
                                            color: Colors.white,
                                          ),
                                        );
                                      }
                                      return Text(
                                        "0",
                                        style: TextStyle(color: Colors.white),
                                      );
                                    });
                              }),
                            ),
                            child: Icon(
                              Icons.local_shipping,
                              size: 30,
                              color: Colors.blue,
                            )),
                    text: "Livraison",
                    height: 70,
                  ),
                  Tab(
                    icon: /*Icon(
                      Icons.list_alt_outlined,
                      color: AppColors.blueR,
                      size: 30,
                    ),*/
                        Badge(
                            badgeColor: Colors.red,
                            padding: EdgeInsets.all(5),
                            position: BadgePosition.bottomEnd(),
                            badgeContent: Consumer<CommandeController>(
                              builder: ((context, value, child) {
                                return FutureBuilder(
                                    future: value.recupNombreCmd(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<int> snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data.toString(),
                                          style: TextStyle(
                                            fontSize: snapshot.data
                                                        .toString()
                                                        .length <
                                                    2
                                                ? 12
                                                : 9,
                                            color: Colors.white,
                                          ),
                                        );
                                      }
                                      return Text(
                                        "0",
                                        style: TextStyle(color: Colors.white),
                                      );
                                    });
                              }),
                            ),
                            child: Icon(
                              Icons.list_alt_outlined,
                              size: 30,
                              color: Colors.blue,
                            )),
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
