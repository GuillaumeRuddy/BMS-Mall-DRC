import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_drc/app/app_constatns.dart';
import 'package:mall_drc/pages/home.dart';

class echecLivr extends StatefulWidget {
  const echecLivr({Key? key}) : super(key: key);

  @override
  State<echecLivr> createState() => _SuccessState();
}

class _SuccessState extends State<echecLivr> {
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
            image: AssetImage("assets/img/L.png"),
            height: 150,
            width: 150,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Vous n'avez aucune livraison pour le moment",
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
