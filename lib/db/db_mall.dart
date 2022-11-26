import 'dart:async';
import 'dart:ffi';

import 'package:mall_drc/model/produit.dart';
import 'package:mall_drc/pages/panier.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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
    String path = join(documentDirectory.path, 'panier.bd');
    var bdd = await openDatabase(path, version: 1, onCreate: creationBase);
    return bdd;
  }

  creationBase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE panier(id VARCHAR UNIQUE,nom TEXT, prix DOUBLE, quantite INTEGER, description TEXT, image TEXT, marchand_id TEXT)");
  }

//idsql INTEGER PRIMARY KEY AUTO_INCREMENT,
  Future<Produit> InsertionProduit(Produit prod) async {
    var dbMall = await BDD;
    print("**** le reotur de MalL BD ****");
    print(dbMall);
    print("-------------------------");
    print(prod);
    print("**** fin du retour de MalL BD ****");
    await dbMall!.insert('panier', prod.toMap());
    return prod;
  }
}
