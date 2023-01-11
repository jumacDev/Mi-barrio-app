import 'dart:convert';
import 'package:mi_barrio_app/controller/server_connection.dart';
import 'package:mi_barrio_app/model/stores.dart';

class StoreDAO{
  static final List<Store> stores = [];

  static Future<void> addStoresFromServer() async{
    var srvConn = ServerConnection();
    await srvConn.select('Stores').then((storesData) {
      var json = jsonDecode(storesData);
      List records = json["data"];
      for (var element in records) {
        stores.add(Store.fromJson(element));
      }
    });
  }
}