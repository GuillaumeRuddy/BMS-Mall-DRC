import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app/app_constatns.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    "Details produits",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Spacer(),
                /*Icon(
                  Icons.more_vert,
                  size: 25.0,
                  color: Colors.white,
                )*/
              ],
            ),
            //fin entete
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Image(
              image: AssetImage("assets/img/ps4_console_blue_1.png"),
              height: 305,
              width: 305,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Text(
              "PLAY STATION 4",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "DESCRIPTION",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 17,
                  color: AppColors.ecrit,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "Lorsque vous tranférez le programme vers un autre ordinateur, Lorsque vous tranférez le programme vers un autre ordinateur, vous devez réinitialiser le Mode Auto L\'activation devrait être en automatique, mais ce mode peut ne pas être optimal pour votre nouvel ordinateur",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 17, color: AppColors.blueR),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Text(
                  "En Stock : ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.ecrit,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "50",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.blueR,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10)
                          ]),
                      child: Icon(
                        CupertinoIcons.minus,
                        size: 18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "02",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10)
                          ]),
                      child: Icon(
                        CupertinoIcons.plus,
                        size: 18,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Text(
                  "Couleur : ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.ecrit,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Bleu, ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.blueR,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Noir, ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.blueR,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rouge",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.blueR,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: AppColors.blueR,
                borderRadius: BorderRadius.circular(1),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "150\$",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.cart_badge_plus),
                  label: Text(
                    "Ajouter au panier",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.ecrit),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
