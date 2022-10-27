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
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SizedBox(
            height: 64,
          ),
          Text(titre,
              style: TextStyle(
                  color: AppColors.ecrit,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
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
