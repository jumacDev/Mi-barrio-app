import 'package:mi_barrio_app/model/products.dart';

class Order{
  int id;
  List<Product> productlist = [];

  Order(this.id);

  Order.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString());

}