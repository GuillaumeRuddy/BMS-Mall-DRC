import 'package:flutter/material.dart';

class ApiUrl {
  //Base URL     https://malldrc.mithap.org/api/mall/v1/marchand/d033e22ae348aeb5660fc2140aec35850c4da997
  static String baseUrl = "https://malldrc.mithap.org";
  //EndPoint pour enregistrement
  String enregistrement =
      "$baseUrl/api/mall/v1/client/inscription/d033e22ae348aeb5660fc2140aec35850c4da997";
  //EndPoint pour se connecter
  String connexion =
      "$baseUrl/api/mall/v1/client/d033e22ae348aeb5660fc2140aec35850c4da997";
  //EndPoint pour recuperer les produits
  String produits = "$baseUrl/api/mall/v1/produits";
  //EndPoint pour recuperer un produit
  String produit = "$baseUrl/api/mall/v1/produit/";
  //EndPoint pour recuperer les categories
  String categorie =
      "$baseUrl/api/mall/v1/categorie/d033e22ae348aeb5660fc2140aec35850c4da997";
  /*static const String commande =
      "api/mall/v1/client/inscription/d033e22ae348aeb5660fc2140aec35850c4da997";*/
}
