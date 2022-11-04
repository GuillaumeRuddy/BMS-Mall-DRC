// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';
import 'package:mall_drc/pages/presentation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Demarage extends StatelessWidget {
  int timing = 0;

  Demarage({Key? key, required this.timing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: timing), () /*async*/ {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Presentation()));

      /*final pref = await SharedPreferences.getInstance();
      final showPres = pref.getBool("showPres") ?? false;
      showPres
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()))
          : Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Presentation()));*/
    });

    return Scaffold(
      body: Container(
        color: AppColors.blueR,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                //height: MediaQuery.of(context).size.height / 2,
                //width: MediaQuery.of(context).size.width / 2,
                child: Image(
              image: AssetImage('assets/splash_icon.png'),
            )),
            Text(
              'Version 1.0',
              style: TextStyle(
                  fontSize: 20,
                  color: AppColors.darkWhite,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
