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
          child: Card(
            shadowColor: Colors.black,
            elevation: 5.0,
            child: Stack(
              children: [
                Image.network(
                  "${ApiUrl.baseUrl}/" + prod.image!,
                  width: double.infinity,
                  //height: size.height * 0.3,
                  fit: BoxFit.cover,
                ),
                /*Opacity(
                  opacity: 0.2,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.3,
                    color: Colors.grey,
                  ),
                ),*/
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 26.0,
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    prod.nom ?? "",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: AppColors.ecrit,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Row(
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
                )
              ],
            ),
          ),
        ));
  }
}
