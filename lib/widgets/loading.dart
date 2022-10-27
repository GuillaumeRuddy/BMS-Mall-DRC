import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mall_drc/app/app_constatns.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blueR,
      child: Center(child: SpinKitChasingDots(color: Colors.white, size: 50)),
    );
  }
}
