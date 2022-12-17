// To parse this JSON data, do
//
//     final marchand = marchandFromJson(jsonString);

import 'dart:convert';

Marchand marchandFromJson(String str) => Marchand.fromJson(json.decode(str));

String marchandToJson(Marchand data) => json.encode(data.toJson());

class Marchand {
  Marchand({
    this.id,
    this.nomEntreprise,
    this.emailEntreprise,
    this.numeroEntreprise,
    this.adresseEntreprise,
    this.categorie,
    this.document,
    this.apropos,
    this.image,
    this.statut,
    this.disponibilite,
    this.ouverture,
    this.fermeture,
  });

  String? id;
  String? nomEntreprise;
  String? emailEntreprise;
  String? numeroEntreprise;
  String? adresseEntreprise;
  String? categorie;
  String? document;
  String? apropos;
  String? image;
  String? statut;
  String? disponibilite;
  String? ouverture;
  String? fermeture;

  factory Marchand.fromJson(Map<String, dynamic> json) => Marchand(
      id: json["id"] == null ? null : json["id"],
      nomEntreprise:
          json["nom_entreprise"] == null ? null : json["nom_entreprise"],
      emailEntreprise:
          json["email_entreprise"] == null ? null : json["email_entreprise"],
      numeroEntreprise:
          json["numero_entreprise"] == null ? null : json["numero_entreprise"],
      adresseEntreprise: json["adresse_entreprise"] == null
          ? null
          : json["adresse_entreprise"],
      categorie: json["categorie"] == null ? null : json["categorie"],
      document: json["document"] == null ? null : json["document"],
      apropos: json["apropos"] == null ? null : json["apropos"],
      image: json["image"] == null ? null : json["image"],
      statut: json["statut"] == null ? null : json["statut"],
      disponibilite:
          json["disponibilite"] == null ? null : json["disponibilite"],
      ouverture: json["ouverture"] == null ? null : json["ouverture"],
      fermeture: json["fermeture"] == null ? null : json["fermeture"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nom_entreprise": nomEntreprise == null ? null : nomEntreprise,
        "email_entreprise": emailEntreprise == null ? null : emailEntreprise,
        "numero_entreprise": numeroEntreprise == null ? null : numeroEntreprise,
        "adresse_entreprise":
            adresseEntreprise == null ? null : adresseEntreprise,
        "categorie": categorie == null ? null : categorie,
        "document": document == null ? null : document,
        "apropos": apropos == null ? null : apropos,
        "image": image == null ? null : image,
        "statut": statut == null ? null : statut,
        "disponibilite": disponibilite == null ? null : disponibilite,
        "ouverture": ouverture == null ? null : ouverture,
        "fermeture": fermeture == null ? null : fermeture
      };
}
