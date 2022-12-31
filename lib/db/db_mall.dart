import 'dart:async';

import 'package:mall_drc/model/produit.dart';
import 'package:mall_drc/pages/panier.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../model/adresse.dart';

class DbMAll {
  static Database? db;

  Future<Database?> get BDD async {
    if (db != null) {
      return db;
    }
    db = await initDatabase();
    return db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'mall.bd');
    var bdd = await openDatabase(path, version: 2, onCreate: creationBase);
    return bdd;
  }

  creationBase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE panier(id INTEGER PRIMARY KEY,nom TEXT, prix DOUBLE, quantite INTEGER, description TEXT, image TEXT, marchand_id TEXT, monnaie TEXT, idClient TEXT)");
    await db.execute(
        "CREATE TABLE adresse(id INTEGER PRIMARY KEY,nom TEXT, adresse TEXT, description TEXT, statut TEXT)");
  }

  supprimertable(Database db, int version) async {
    await db.execute("DROP TABLE panier");
  }

//idsql INTEGER PRIMARY KEY AUTO_INCREMENT,
  Future<Produit> InsertionProduit(Produit prod) async {
    var dbMall = await BDD;
    print("**** le reotur de MalL BD ****");
    print(dbMall);
    print("-------------------------");
    print(prod);
    print(prod.idClient);
    print("**** fin du retour de MalL BD ****");
    await dbMall!.insert('panier', prod.toMap());
    return prod;
  }

  Future<Adresse> InsertionAdresse(Adresse adr) async {
    var dbMall = await BDD;
    await dbMall!.insert('adresse', adr.toMap());
    return adr;
  }

  Future<List<Produit>> getListPanier() async {
    var dbMall = await BDD;
    final List<Map<String, Object?>> requet = await dbMall!.query('panier');
    return requet.map((e) => Produit.fromJson(e)).toList();
  }

  Future<List<Adresse>> getListAdresse() async {
    var dbMall = await BDD;
    final List<Map<String, Object?>> requet = await dbMall!.query('adresse');
    return requet.map((e) => Adresse.fromJson(e)).toList();
  }

  Future<List<Produit>> getListPanierById(String id) async {
    var dbMall = await BDD;
    final List<Map<String, Object?>> requet =
        await dbMall!.rawQuery('SELECT * FROM panier WHERE id = ?', ['${id}']);
    return requet.map((e) => Produit.fromJson(e)).toList();
  }

  Future<List<Adresse>> getListAdresseById(String id) async {
    var dbMall = await BDD;
    final List<Map<String, Object?>> requet =
        await dbMall!.rawQuery('SELECT * FROM adresse WHERE id = ?', ['${id}']);
    return requet.map((e) => Adresse.fromJson(e)).toList();
  }

  Future<int> getNbrListPanier() async {
    var dbMall = await BDD;
    final List<Map<String, Object?>> requet = await dbMall!.query('panier');
    return requet.length;
  }

  /*Future<int> getNbrListPanier(String id) async {
    var dbMall = await BDD;
    final List<Map<String, Object?>> requet =
        await dbMall!.rawQuery('SELECT * FROM panier WHERE id = ?', ['${id}']);
    return requet.length;
  }*/

  Future<String> suppressionProduitPanier(String id) async {
    var dbMall = await BDD;
    int reponse =
        await dbMall!.delete('panier', where: 'id = ?', whereArgs: [id]);
    print("----------- la reponse de la suppression -----------");
    print(reponse);
    print("----------- fin de la reponse de la suppression -----------");
    return reponse.toString();
  }

  Future<String> suppressionAdresse(String nom) async {
    var dbMall = await BDD;
    int reponse =
        await dbMall!.delete('adresse', where: 'nom = ?', whereArgs: [nom]);
    print("----------- la reponse de la suppression -----------");
    print(reponse);
    print("----------- fin de la reponse de la suppression -----------");
    return reponse.toString();
  }

  Future<int> suppressionTousProduitPanier() async {
    var dbMall = await BDD;
    int reponse = await dbMall!.delete('panier');
    print("----------- la reponse de toute la suppression -----------");
    print(reponse);
    print("----------- fin de la reponse de toute la suppression -----------");
    return reponse;
  }

  Future<int> updateProduitPanier(Produit prod) async {
    var dbMall = await BDD;
    var reponse = await dbMall!
        .update('panier', prod.toMap(), where: 'id = ?', whereArgs: [prod.id]);
    print("++++++ la reponse de la mise à jour ++++++");
    print(reponse);
    return reponse;
  }
}
