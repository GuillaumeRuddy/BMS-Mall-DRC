import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';

class echecCmd extends StatefulWidget {
  const echecCmd({Key? key}) : super(key: key);

  @override
  State<echecCmd> createState() => _SuccessState();
}

class _SuccessState extends State<echecCmd> {
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
            image: AssetImage("assets/img/no_product.png"),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Aucune Commande disponible pour le moment",
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
