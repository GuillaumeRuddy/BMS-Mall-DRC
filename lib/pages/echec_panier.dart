import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';

class echecPanier extends StatefulWidget {
  const echecPanier({Key? key}) : super(key: key);

  @override
  State<echecPanier> createState() => _SuccessState();
}

class _SuccessState extends State<echecPanier> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/img/no_cart.png"),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Aucun Produit dans le panier",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
