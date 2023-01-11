import 'package:mi_barrio_app/model/products.dart';
import 'package:mi_barrio_app/model/stores.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DbManager{
  static late Database _database;
  final String _dataBaseName = "MiBarrioApp.db";

  DbManager._();
  static final DbManager db = DbManager._();
  var initialize = false;

  Future<Database> get database async {
    if (!initialize){
      _database = await initDB();
      initialize = true;
    }
    return _database;
  }

  final String _createtablestore =
      "CREATE TABLE Store("
      "idStore INTEGER PRIMARY KEY,"
      "namestore TEXT,"
      "adresstore TEXT,"
      "latitude REAL,"
      "longitude REAL,"
      "cellphonestore TEXT,"
      "email TEXT,"
      "webpage TEXT,"
      "typestore TEXT,"
      "Logo TEXT"
      ")";

  final String _createtabletemporder =
      "CREATE TABLE TempOrder("
      "id INTEGER,"
      "idstore INTEGER,"
      "name TEXT,"
      "price INTEGER,"
      "unity TEXT,"
      "cant INTEGER"
      ")";

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dataBaseName);
    return await openDatabase(path, version: 5, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(_createtablestore);
          await db.execute(_createtabletemporder);
        }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
          if (oldVersion < newVersion) {
            await db.execute("DROP TABLE IF EXISTS Store");
            await db.execute(_createtablestore);
            await db.execute("DROP TABLE IF EXISTS TempOrder");
            await db.execute(_createtabletemporder);
          }
        });
  }

  insertNewStore(Store td) async {
    final db = await database;
    var res = await db.insert("Store", td.toJson());
    return res;
  }

  insertNewTempOrder(Product product) async {
    final db = await database;
    var selectPdt = await db.rawQuery(
        "SELECT cant FROM TempOrder WHERE id = " + product.id.toString());
    if (selectPdt.isNotEmpty) {
      int nuevaCantidad = int.parse(selectPdt[0]["cant"].toString()) + 1;
      var updatePdt = await db.rawUpdate("UPDATE TempOrder SET cant = " +
          nuevaCantidad.toString() +
          " WHERE id = " +
          product.id.toString());
      return updatePdt;
    }
    else {
      var res = await db.insert("TempOrder", product.toJson());
      return res;
    }
  }

  deleteTempOrder(Product product) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT cant FROM TempOrder WHERE id = " + product.id.toString());
    if (int.parse(res[0]["cant"].toString()) > 1) {
      int nuevaCantidad = int.parse(res[0]["cant"].toString()) - 1;
      var updatePdt = await db.rawUpdate("UPDATE TempOrder SET cant = " +
          nuevaCantidad.toString() +
          " WHERE id = " +
          product.id.toString());
      return updatePdt;
    }
    else {
      var deletePdt = await db.rawDelete(
          "DELETE FROM TempOrder WHERE id = " + product.id.toString());
      return deletePdt;
    }
  }

  Future<List<Store>> storesList(String query) async {
    final db = await database;
    var res = await db.rawQuery(query);
    List<Store> list = [];
    if (res.isNotEmpty) {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Store.fromJson(t));
      }
    }
    return list;
  }

  Future<List<Product>> pdtTempList() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM TempOrder");
    List<Product> list = [];
    if (res.isNotEmpty) {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Product.fromJson(t));
      }
    }
    return list;
  }

  //borra el pedido temporal completamente
  Future deleteTempList() async{
    final db = await database;
    await db.rawQuery("DELETE FROM TempOrder");
  }

}