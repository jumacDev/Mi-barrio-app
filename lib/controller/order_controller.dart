import 'dart:convert';
import 'package:mi_barrio_app/controller/server_connection.dart';
import 'package:mi_barrio_app/model/order.dart';
import 'package:mi_barrio_app/model/products.dart';

class OrderDao{
  static final List<Order> orderslist = [];

  static Future<void> addOrdersFromServer() async{
    var srvConn = ServerConnection();
    await srvConn.select('Orders').then((ordersData) {
      var json = jsonDecode(ordersData);
      List records = json["data"];
      for (var index = 0; index < records.length; index++) {
        orderslist.add(Order.fromJson(records[index]));
        var temp = records[index]['products'].toString();
        List<String> data = temp.split('|');
        for(var pdt in data){
          orderslist[orderslist.length-1].productlist.add(Product.fromOrderString(pdt));
        }
      }
    });
  }

}