import 'package:flutter/material.dart';

class ApiUrl {
  //Token
  static String token = "d033e22ae348aeb5660fc2140aec35850c4da997";
  //Base URL     https://malldrc.mithap.org/api/mall/v1/marchand/d033e22ae348aeb5660fc2140aec35850c4da997
  static String baseUrl = "https://malldrc.mithap.org";
  //static String baseUrl = "https://malldrc.com";
  //Endpoint pour UniPesa
  String urlUniPesa = "https://api.unipesa.tech";
  //EndPoint pour enregistrement
  String enregistrement = "$baseUrl/api/mall/v1/client/inscription/$token";
  //EndPoint pour se connecter
  String connexion = "$baseUrl/api/mall/v1/client/$token";
  //EndPoint pour modifier le profile
  String majProfile = "$baseUrl/api/mall/v1/client/profil/$token";
  //EndPoint pour modifier la photo de profile
  String majPhotoProfile = "$baseUrl/api/mall/v1/client/photoprofil/$token";
  //EndPoint pour recuperer les produits
  String produits = "$baseUrl/api/mall/v1/produits";
  //EndPoint pour recuperer les produits par marchant
  String produitsById = "$baseUrl/api/mall/v1/produits";
  //EndPoint pour recuperer un produit
  String produit = "$baseUrl/api/mall/v1/produit/";
  //EndPoint pour recuperer les categories
  String categorie = "$baseUrl/api/mall/v1/categorie";
  //EndPoint pour recuperer les marchants
  String marchant = "$baseUrl/api/mall/v1/marchand/filtre/{categorie}/$token";
  //EndPoint pour envoie les commmandes
  String commande = "$baseUrl/api/mall/v1/commande/$token";
  String livraison = "$baseUrl/api/mall/v1/livraison/$token";
}
