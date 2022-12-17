import 'package:flutter/material.dart';

class AppColors {
  static const Color ecrit = Color.fromARGB(255, 183, 150, 5);
  static const Color darkWhite = Color.fromRGBO(240, 239, 247, 1);
  static const Color grey = Color.fromRGBO(154, 153, 159, 1);
  static const Color blue = Color.fromARGB(255, 2, 32, 52);
  static const Color blueR = Color.fromARGB(255, 4, 2, 37);

  static List<Map> listCategorie = [
    {
      "nom": "Livraison",
      "icon": Icons.moped,
      "desc": "Livraison en un temps record"
    },
    {
      "nom": "Pharmacie",
      "icon": Icons.local_hospital,
      "desc": "Problème de santé?"
    },
    {
      "nom": "Boutique",
      "icon": Icons.shopping_bag,
      "desc": "Vos produits en boutique ici"
    },
    {
      "nom": "Restaurant",
      "icon": Icons.restaurant,
      "desc": "Amoureux des bon mets"
    },
    {
      "nom": "Epicerie",
      "icon": Icons.shopping_cart,
      "desc": "Produits ici en marcher"
    },
    {
      "nom": "Autres",
      "icon": Icons.dashboard,
      "desc": "Vos autres produits divers"
    },
  ];

  static List<Map> listMarchand = [
    {"nom": "O Poeta", "icon": Icons.moped, "desc": "Entreprise de pizza"},
    {
      "nom": "Prince Pharma",
      "icon": Icons.local_hospital,
      "desc": "Vos produits en depot ici"
    },
    {
      "nom": "Lina Boutique",
      "icon": Icons.shopping_bag,
      "desc": "Le shooping devient facile"
    },
    {
      "nom": "Chez Paul",
      "icon": Icons.restaurant,
      "desc": "Venew gouttez à mes mets"
    },
    {
      "nom": "Epicerie du coin",
      "icon": Icons.shopping_cart,
      "desc": "Produits ici en marcher"
    },
    {
      "nom": "Vodacom",
      "icon": Icons.dashboard,
      "desc": "la communication devient facile"
    },
  ];
}
