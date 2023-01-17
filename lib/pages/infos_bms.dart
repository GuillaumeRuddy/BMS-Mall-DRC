import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../app/app_constatns.dart';

class InfosBMS extends StatelessWidget {
  const InfosBMS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "A propos de MALL DRC",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Image(
                  image: AssetImage("assets/splash_icon.png"),
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                ),
              ),
              //profileImageVue(),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Center(
                      child: Text(
                    "MALL DRC",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold, color: AppColors.ecrit),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Description",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline6!.copyWith(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Je souhaite enregistrer les préférences de l'utilisateur à l'aide de SharedPreference de Flutter. Mais les préférences enregistrées sont TOUTES nulles au nouveau démarrage (impossibled'enregistrer la session si je démarre mes applications), ma préférence partagée ne fonctionnepas dans mon projet flutter.",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Objectif",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline6!.copyWith(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Je souhaite enregistrer les préférences de l'utilisateur à l'aide de SharedPreference de Flutter. Mais les préférences enregistrées sont TOUTES nulles au nouveau démarrage (impossibled'enregistrer la session si je démarre mes applications), ma préférence partagée ne fonctionnepas dans mon projet flutter.",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.justify,
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
