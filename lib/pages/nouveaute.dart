import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/success.dart';

import '../model/category.dart';
import '../widgets/category_card.dart';

class Nouveaute extends StatefulWidget {
  const Nouveaute({Key? key}) : super(key: key);

  @override
  State<Nouveaute> createState() => _NouveauteState();
}

class _NouveauteState extends State<Nouveaute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: AppColors.blueR,
            padding: EdgeInsets.all(15),
            //entete
            child: Row(
              children: [
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
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Nouveaute",
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
          Container(
            height: 700,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: Color.fromARGB(77, 233, 230, 230),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            child: SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                //scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 24,
                ),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    category: categoryList[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
