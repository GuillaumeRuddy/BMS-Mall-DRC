import 'package:flutter/material.dart';
import 'package:mall_drc/model/produit.dart';
import 'package:provider/provider.dart';

import '../app/endPoint.dart';

class ListItemHome extends StatelessWidget {
  final Produit prod;
  final bool isNew;
  final VoidCallback? addToFavorites;
  bool isFavorite;
  ListItemHome({
    Key? key,
    required this.prod,
    required this.isNew,
    this.addToFavorites,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  "${ApiUrl.baseUrl}/" + prod.image!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 50,
                  height: 25,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: isNew ? Colors.black : Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          'NEW',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // TODO: Create one component for the favorite button
          Positioned(
            left: size.width * 0.38,
            bottom: size.height * 0.12,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.grey,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20.0,
                child: InkWell(
                  onTap: addToFavorites,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    size: 20.0,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Row(
                  children: [
                    RatingBarIndicator(
                      itemSize: 25.0,
                      rating: product.rate?.toDouble() ?? 4.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '(100)',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),*/
                Text(
                  prod.quantite ?? "",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  prod.nom ?? "",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6.0),
                isNew
                    ? Text(
                        prod.prix.toString(),
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.grey,
                            ),
                      )
                    : Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: prod.prix.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            /*TextSpan(
                              text:
                                  '  ${product.price * (product.discountValue!) / 100}\$',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    color: Colors.red,
                                  ),
                            ),*/
                          ],
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
