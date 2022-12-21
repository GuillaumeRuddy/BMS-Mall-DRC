import 'package:flutter/cupertino.dart';

class Adresse {
  String? id;
  String? nom;
  String? adresse;
  String? description;
  String? statut;

  Adresse({this.id, this.nom, this.adresse, this.description, this.statut});

  factory Adresse.fromJson(Map<String, dynamic> i) => Adresse(
        id: i["id"] == null ? null : i["id"].toString(),
        nom: i["nom"] == null ? null : i["nom"],
        adresse: i["adresse"] == null ? null : i["adresse"],
        description: i["description"] == null ? null : i["description"],
        statut: i["statut"] == null ? null : i["statut"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? "" : id,
        "nom": id == null ? null : nom,
        "adresse": id == null ? null : adresse,
        "description": id == null ? null : description,
        "statut": id == null ? null : statut
      };
}
