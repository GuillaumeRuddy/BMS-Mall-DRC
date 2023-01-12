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
              image: AssetImage("assets/img/no_product.png"),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Aucun Produit dans cette categorie",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                /* GoogleFonts.lobster(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),*/
              ),
            ),
            /*SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColors.blueR),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Home()));
              },
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Accueil",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),*/
          ],
        ),
      ),
    );
  }
}
