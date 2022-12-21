import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/controler/categorieController/categorieController.dart';
import 'package:mall_drc/model/categorie.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/success.dart';
import 'package:mall_drc/widgets/cardCategorie.dart';
import 'package:mall_drc/widgets/category_card.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategorieState();
}

class _CategorieState extends State<Categories> {
  List<Categorie> listCategories = [];

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var catCtrl = context.read<CategorieController>();
      await catCtrl.RecupCategorie();
      listCategories = catCtrl.listDesCategorie;
      setState(() {});
      //await recupCategorie();
    });
  }

  @override
  Widget build(BuildContext context) {
    //List<Map> cat = AppColors.listCategorie;
    return Material(
      child: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //entete
                Container(
                  color: AppColors.blueR,
                  padding: EdgeInsets.all(15),
                  //detail ligne entete
                  child: Row(
                    children: [
                      //icone retour
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                      // text entete
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      /*Spacer(),
                          Icon(
                            Icons.more_vert,
                            size: 25.0,
                            color: Colors.white,
                          )*/
                    ],
                  ),
                ),
                //details
                Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: listCategories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CategorieCard(
                            nom: listCategories[index].nom,
                            text: listCategories[index].description,
                            icone: listCategories[index].icone);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
