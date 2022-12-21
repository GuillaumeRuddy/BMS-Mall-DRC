import 'package:flutter/material.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/model/categorie.dart';
import 'package:mall_drc/model/marchant.dart';
import 'package:mall_drc/pages/marchant.dart';
import 'package:mall_drc/pages/vendeur.dart';

class MarchantCard extends StatelessWidget {
  Marchand? vendeur;
  MarchantCard({Key? key, this.vendeur}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("le vendeur que j'envoi dans la card");
          print(vendeur);
          print(vendeur!.id);
          print(vendeur!.nomEntreprise);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Vendeur(march: vendeur)));
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 7,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 5,
                  margin: EdgeInsets.only(right: 15),
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.image,
                    color: Colors.black,
                    size: 80,
                    /*Image(
                              image: AssetImage("assets/img/fedex-express.png")*/
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      vendeur?.nomEntreprise ?? "",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.ecrit,
                      ),
                    ),
                    Text(
                      vendeur?.ouverture ?? "",
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.arrow_forward_ios_rounded))
            ],
          ),
        ));
  }
}
