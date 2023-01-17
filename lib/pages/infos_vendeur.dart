import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/model/marchant.dart';

import '../app/app_constatns.dart';
import '../app/endPoint.dart';

class InfoVendeur extends StatefulWidget {
  Marchand? march;
  InfoVendeur({super.key, this.march});

  @override
  State<InfoVendeur> createState() => _InfoVendeurState();
}

class _InfoVendeurState extends State<InfoVendeur> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Information vendeur",
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
        child: Column(
          children: [
            Center(
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Image.network(
                    "${ApiUrl.baseUrl}/${widget.march?.image}",
                    width: double.infinity,
                    height: size.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
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
                  widget.march!.nomEntreprise ?? "",
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w700, color: AppColors.ecrit),
                )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.headline6!.copyWith(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.march!.apropos ?? "",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Adresse",
                  style: Theme.of(context).textTheme.headline6!.copyWith(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.march!.adresseEntreprise ?? "",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Disponibilite",
                  style: Theme.of(context).textTheme.headline6!.copyWith(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.march!.disponibilite ?? "",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Heure d'ouverture : ",
                      style: Theme.of(context).textTheme.headline6!.copyWith(),
                    ),
                    /*SizedBox(
                      width: 30,
                    ),*/
                    Text(
                      widget.march!.ouverture ?? "",
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Heure de fermeture : ",
                      style: Theme.of(context).textTheme.headline6!.copyWith(),
                    ),
                    /*SizedBox(
                      width: 30,
                    ),*/
                    Text(
                      widget.march!.fermeture ?? "",
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                Text(
                  "Telephone",
                  style: Theme.of(context).textTheme.headline6!.copyWith(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.march!.numeroEntreprise ?? "",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "Email",
                  style: Theme.of(context).textTheme.headline6!.copyWith(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.march!.emailEntreprise ?? "",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "Statut",
                  style: Theme.of(context).textTheme.headline6!.copyWith(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.march!.statut ?? "",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "Categorie",
                  style: Theme.of(context).textTheme.headline6!.copyWith(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.march!.categorie ?? "",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.justify,
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
