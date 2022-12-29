import 'dart:convert';

class Utilisateur {
  String? id;
  String? nom;
  String? prenom;
  String? email;
  String? telephone;
  String? motDePasse;
  String? image;

  Utilisateur(
      {this.id,
      this.nom,
      this.prenom,
      this.email,
      this.telephone,
      this.motDePasse,
      this.image});

  factory Utilisateur.fromJson(Map<String, dynamic> i) => Utilisateur(
      id: i["id"].toString(),
      nom: i["nom"],
      prenom: i["prenom"],
      email: i["email"],
      telephone: i["telephone"],
      motDePasse: i["motDePasse"],
      image: i["image"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "telephone": telephone,
        "motDePasse": motDePasse,
        "image": image
      };
}
