import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/app/endPoint.dart';
import 'package:mall_drc/model/produit.dart';
import 'package:mall_drc/pages/details.dart';

class ProduitCard3 extends StatelessWidget {
  final Produit prod;
  const ProduitCard3({Key? key, required this.prod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Details(
                    product: prod,
                  )));
        },
        child: Container(
          height: 200,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(3, 9)),
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.network(
                    "${ApiUrl.baseUrl}/" + prod.image!,
                    //width: double.infinity,
                    //height: size.height * 0.3,
                    height: 150,
                    //fit: BoxFit.scaleDown,
                  ),
                ),
                Text(
                  prod.nom ?? "",
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AppColors.ecrit,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                SizedBox(height: 4),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prod.prix.toString(),
                      style: GoogleFonts.poppins(
                          color: Colors.red[700],
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      prod.monnaie ?? 'CDF',
                      style: GoogleFonts.poppins(
                          color: AppColors.blueR,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
