import 'dart:convert';

Commande? commandeFromJson(String str) => Commande.fromJson(json.decode(str));

String commandeToJson(Commande? data) => json.encode(data!.toJson());

class Commande {
  Commande(
      {this.id,
      this.marchandId,
      this.idClient,
      this.idProduit,
      this.prix,
      this.quantite,
      this.aretirer,
      this.adresse,
      this.description,
      this.reference,
      this.attribution,
      this.statut,
      this.prixdriver,
      this.vue,
      this.vuedriver,
      this.vuebms,
      this.vuelivraison});

  int? id;
  int? marchandId;
  String? idClient;
  String? idProduit;
  String? prix;
  String? quantite;
  String? aretirer;
  String? adresse;
  String? description;
  String? reference;
  String? attribution;
  String? statut;
  String? prixdriver;
  String? vue;
  String? vuedriver;
  String? vuebms;
  String? vuelivraison;

  factory Commande.fromJson(Map<String, dynamic> json) => Commande(
      id: json["id"],
      marchandId: json["marchand_id"],
      idClient: json["id_client"],
      idProduit: json["id_produit"],
      prix: json["prix"],
      quantite: json["quantite"],
      aretirer: json["aretirer"],
      adresse: json["adresse"],
      description: json["description"],
      reference: json["reference"],
      attribution: json["attribution"],
      statut: json["statut"],
      prixdriver: json["prixdriver"],
      vue: json["vue"],
      vuedriver: json["vuedriver"],
      vuebms: json["vuebms"],
      vuelivraison: json["vuelivraison"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "marchand_id": marchandId,
        "id_client": idClient,
        "id_produit": idProduit,
        "prix": prix,
        "quantite": quantite,
        "aretirer": aretirer,
        "adresse": adresse,
        "description": description,
        "reference": reference,
        "attribution": attribution,
        "statut": statut,
        "prixdriver": prixdriver,
        "vue": vue,
        "vuedriver": vuedriver,
        "vuebms": vuebms,
        "vuelivraison": vuelivraison
      };
}
