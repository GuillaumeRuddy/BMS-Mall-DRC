import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class AucuneDonne extends StatelessWidget {
  String imagePath;
  String? text;
  AucuneDonne({Key? key, required this.imagePath, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Image.asset('assets/img/${imagePath}'), Text('${text}')],
        ),
      ),
    );
  }
}
