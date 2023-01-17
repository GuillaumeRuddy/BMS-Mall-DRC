import 'package:flutter/material.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/model/categorie.dart';
import 'package:mall_drc/model/marchant.dart';
import 'package:mall_drc/pages/marchant.dart';
import 'package:mall_drc/pages/vendeur.dart';

import '../app/endPoint.dart';

class MarchantCard extends StatelessWidget {
  Marchand? vendeur;
  MarchantCard({Key? key, this.vendeur}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*GestureDetector(
      onTap: () {
        print("le vendeur que j'envoi dans la card");
        print(vendeur);
        print(vendeur!.id);
        print(vendeur!.nomEntreprise);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Vendeur(march: vendeur)));
      },
      child: Card(
          margin: EdgeInsets.all(5.0),
          child: ListTile(
              leading: Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width / 4,
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: Image.network(
                  "${ApiUrl.baseUrl}/${vendeur!.image}",
                  width: double.infinity,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                vendeur?.nomEntreprise ?? "",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.ecrit,
                ),
              ),
              subtitle: Text(
                vendeur?.apropos ?? "",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.ecrit,
                ),
              ),
              trailing: Container(
                child: vendeur!.disponibilite == "1"
                    ? Text("Fermer",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Colors.red[800],
                            ))
                    : Text("Ouvert",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Colors.blue,
                            )),
              ))),
    );*/

        GestureDetector(
            onTap: () {
              print("le vendeur que j'envoi dans la card");
              print(vendeur);
              print(vendeur!.id);
              print(vendeur!.nomEntreprise);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => Vendeur(march: vendeur)));
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 7,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 4,
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: Image.network(
                          "${ApiUrl.baseUrl}/${vendeur!.image}",
                          width: double.infinity,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              vendeur?.nomEntreprise ?? "",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.ecrit,
                              ),
                            ),
                            Text(
                              vendeur?.apropos ?? "",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            vendeur!.disponibilite == "1"
                                ? Text("Fermer",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          color: Colors.red[800],
                                        ))
                                : Text("Ouvert",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          color: Colors.blue,
                                        )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios_rounded))
                ],
              ),
            ));
  }
}
