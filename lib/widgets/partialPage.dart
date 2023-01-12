import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mall_drc/app/app_constatns.dart';

Widget buildPage({
  required Color coleur,
  required String image,
  required String titre,
  required String sousTitre,
}) =>
    Container(
      color: coleur,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            //fit: BoxFit.cover,
            //width: double.infinity,
            height: 300,
            width: 300,
            /*height: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.height /12,*/
          ),
          SizedBox(
            height: 64,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(titre,
                style: TextStyle(
                    color: AppColors.ecrit,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Text(sousTitre,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center),
          )
        ],
      ),
    );
