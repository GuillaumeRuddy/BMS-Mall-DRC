class Produit {
  String? id;
  String? nom;
  String? prix;
  String? quantite;
  String? description;

  Produit({this.id, this.nom, this.prix, this.quantite, this.description});

  factory Produit.fromJson(Map<String, dynamic> i) => Produit(
      id: i["id"] == null ? null : i["id"],
      nom: i["nom"] == null ? null : i["nom"],
      prix: i["prix"] == null ? null : i["prix"],
      quantite: i["quantite"] == null ? null : i["quantite"],
      description: i["description"] == null ? null : i["description"]);

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "nom": id == null ? null : nom,
        "prix": id == null ? null : prix,
        "quantite": id == null ? null : quantite,
        "description": id == null ? null : description,
      };
}
