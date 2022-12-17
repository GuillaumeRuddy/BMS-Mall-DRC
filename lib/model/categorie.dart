import 'package:flutter/cupertino.dart';

class Categorie {
  String? id;
  String? nom;
  String? description;
  String? icone;

  Categorie({this.id, this.nom, this.description, this.icone});

  factory Categorie.fromJson(Map<String, dynamic> i) => Categorie(
        id: i["id"] == null ? null : i["id"].toString(),
        nom: i["nom"] == null ? null : i["nom"],
        description: i["description"] == null ? null : i["description"],
        icone: i["icone"] == null ? null : i["icone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? "" : id,
        "nom": id == null ? null : nom,
        "description": id == null ? null : description,
        "icone": id == null ? null : icone
      };
}
