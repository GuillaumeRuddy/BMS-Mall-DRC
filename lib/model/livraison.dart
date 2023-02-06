import 'dart:convert';

Livraison livraisonFromJson(String str) => Livraison.fromJson(json.decode(str));

String livraisonToJson(Livraison data) => json.encode(data.toJson());

class Livraison {
  Livraison({
    this.id,
    this.clientId,
    this.nom,
    this.adresse,
    this.telephone,
    this.emplacement,
    this.details,
    this.adresseDestination,
    this.nomDestinataire,
    this.telephoneDestination,
    this.reference,
    this.attribution,
    this.statut,
    this.vuebms,
    this.vuedriver,
  });

  int? id;
  int? clientId;
  String? nom;
  String? adresse;
  String? telephone;
  String? emplacement;
  String? details;
  String? adresseDestination;
  String? nomDestinataire;
  String? telephoneDestination;
  String? reference;
  String? attribution;
  String? statut;
  String? vuebms;
  String? vuedriver;

  factory Livraison.fromJson(Map<String, dynamic> json) => Livraison(
        id: json["id"],
        clientId: json["client_id"],
        nom: json["nom"],
        adresse: json["adresse"],
        telephone: json["telephone"],
        emplacement: json["emplacement"],
        details: json["details"],
        adresseDestination: json["adresse_destination"],
        nomDestinataire: json["nom_destinataire"],
        telephoneDestination: json["telephone_destination"],
        reference: json["reference"],
        attribution: json["attribution"],
        statut: json["statut"],
        vuebms: json["vuebms"],
        vuedriver: json["vuedriver"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "nom": nom,
        "adresse": adresse,
        "telephone": telephone,
        "emplacement": emplacement,
        "details": details,
        "adresse_destination": adresseDestination,
        "nom_destinataire": nomDestinataire,
        "telephone_destination": telephoneDestination,
        "reference": reference,
        "attribution": attribution,
        "statut": statut,
        "vuebms": vuebms,
        "vuedriver": vuedriver,
      };
}
