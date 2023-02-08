import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../app/app_constatns.dart';

class PolitiqueConfid extends StatelessWidget {
  const PolitiqueConfid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Politique de confidentialité",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700, color: AppColors.ecrit),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.blueR,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text("1.Collecte de l’information"),
            Text(
                "Nous recueillons des informations lorsque vous vous inscrivez sur notre site ou sur notre application, lorsque vous vous connectez à votre compte, faites un achat, participez à un concours, et / ou lorsque vous vous déconnectez. Les informations recueillies incluent votre nom, votre adresse e-mail, numéro de téléphone, et / ou carte de crédit."),
            Text(
                "En outre, nous recevons et enregistrons automatiquement des informations à partir de votre ordinateur et navigateur, y compris votre adresse IP, vos logiciels et votre matériel, et la page que vous demandez."),
            Text("2. Utilisation des informations"),
            Text(
                "Toutes les informations que nous recueillons auprès de vous peuvent être utilisées pour :"),
            Text(
                "- Personnaliser votre expérience et répondre à vos besoins individuels"),
            Text("- Fournir un contenu publicitaire personnalisé")
          ],
        ),
      )),
    );
  }
}
