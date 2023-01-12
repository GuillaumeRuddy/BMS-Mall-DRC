import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';

class echecProduit extends StatefulWidget {
  const echecProduit({Key? key}) : super(key: key);

  @override
  State<echecProduit> createState() => _SuccessState();
}

class _SuccessState extends State<echecProduit> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 236, 236),
      body: Center(
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
      ),
    );
  }
}
