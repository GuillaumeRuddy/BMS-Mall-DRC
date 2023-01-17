import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/appUtil.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/app/endPoint.dart';
import 'package:mall_drc/model/produit.dart';
import 'package:mall_drc/pages/details.dart';

class ProduitCard2 extends StatelessWidget {
  final Produit prod;
  const ProduitCard2({Key? key, required this.prod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Details(
                    product: prod,
                  )));
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Stack(
            children: [
              Image.network(
                "${ApiUrl.baseUrl}/" + prod.image!,
                width: double.infinity,
                //height: size.height * 0.3,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.3,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Text(
                  prod.nom ?? "",
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prod.prix.toString(),
                      style: GoogleFonts.poppins(
                          color: Colors.red[700],
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 3,
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
              )
            ],
          ),
        )
        /*Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 4.0,
                  spreadRadius: .05,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //image
              Align(
                //alignment: Alignment.topRight,
                alignment: Alignment.center,
                child: Image.network(
                  "${ApiUrl.baseUrl}/" + prod.image!,
                  height: 80.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                prod.nom ?? "",
                maxLines: 2,
                style: GoogleFonts.poppins(
                    color: AppColors.ecrit,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 0.0,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    prod.prix.toString(),
                    style: GoogleFonts.poppins(
                        color: Colors.red[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 3,
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
              Expanded(
                child: Container(
                  //width: 140.0,
                  decoration: BoxDecoration(
                      color: AppColors.ecrit,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0))),
                  child: Center(
                    child: Text(
                      "Détails",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),*/
        );
  }
}
