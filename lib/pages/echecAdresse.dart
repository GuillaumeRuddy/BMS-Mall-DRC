import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';

class echecAdr extends StatefulWidget {
  const echecAdr({Key? key}) : super(key: key);

  @override
  State<echecAdr> createState() => _SuccessState();
}

class _SuccessState extends State<echecAdr> {
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
            image: AssetImage("assets/img/vendor.png"),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "vous n'avez ajouter aucune adresse pour le moment",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: AppColors.blueR),
            ),
          ),
        ],
      ),
    );
  }
}
