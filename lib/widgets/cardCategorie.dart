import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/marchant.dart';

import '../app/endPoint.dart';

class CategorieCard extends StatelessWidget {
  String? nom;
  String? text;
  String? icone;
  CategorieCard({Key? key, this.nom, this.text, this.icone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Marchant(
                    nomCategorie: nom,
                  )));
        },
        child: Container(
            height: MediaQuery.of(context).size.height / 7,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                SvgPicture.network(
                  "${ApiUrl.baseUrl}/${icone}",
                  width: double.infinity,
                  height: size.height * 0.3,
                  fit: BoxFit.fitWidth,
                ),
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.3,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Text(
                        nom ?? "",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    /*Container(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.arrow_forward_ios_rounded))*/
                  ],
                ),
              ],
            )));

    /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /*Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 5,
                  margin: EdgeInsets.only(right: 15),
                  alignment: Alignment.centerRight,
                  child: Icon(
                     icone ?? Icons.shopping_bag,
                    color: Colors.black,
                    size: 80,
                    /*Image(
                              image: AssetImage("assets/img/fedex-express.png")*/
                  )),*/
                  
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      nom ?? "",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.ecrit,
                      ),
                    ),
                    Text(
                      text ?? "",
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
        )); */
  }
}
