import 'package:flutter/cupertino.dart';

class Produit {
  String? id;
  String? nom;
  double? prix;
  String? quantite;
  String? description;
  String image;
  String? marchand_id;

  Produit(
      {this.id,
      this.nom,
      this.prix,
      this.quantite,
      this.description,
      this.image = "img/vendor.png",
      this.marchand_id});

  factory Produit.fromJson(Map<String, dynamic> i) => Produit(
      id: i["id"] == null ? null : i["id"].toString(),
      nom: i["nom"] == null ? null : i["nom"],
      prix: i["prix"] == null ? 0.0 : double.parse(i["prix"].toString()),
      quantite: i["quantite"] == null ? null : i["quantite"].toString(),
      description: i["description"] == null ? null : i["description"],
      image: i["image"] == null ? null : i["image"],
      marchand_id:
          i["marchand_id"] == null ? null : i["marchand_id"].toString());

  Map<String, dynamic> toMap() => {
        "id": id == null ? "" : id,
        "nom": id == null ? null : nom,
        "prix": id == null ? 0.0 : prix,
        "quantite": id == null ? null : quantite,
        "description": id == null ? null : description,
        "image": id == null ? "app_icon.png" : "app_icon.png",
        /*"image": id == null ? null : image,*/
        "marchand_id": id == null ? null : marchand_id
      };
}
