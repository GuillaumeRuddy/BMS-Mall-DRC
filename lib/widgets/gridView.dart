import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mall_drc/model/produit.dart';
import 'package:mall_drc/widgets/produit_card.dart';

class Gridviewer extends StatelessWidget {
  List<Produit> produitsList = [];
  Gridviewer({Key? key, required this.produitsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      //scrollDirection: Axis.horizontal,
      itemCount: produitsList.length,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 20,
        mainAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        return ProduitCard(
          prod: produitsList[index],
        );
      },
    );
  }
}
