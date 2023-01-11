import 'package:mi_barrio_app/controller/server_connection.dart';
import 'package:mi_barrio_app/model/products.dart';

class ProductsDAO{

  Future<List<Product>> getProductsFromServer(String idstore) async{
    final List<Product> products = [];
    var srvConn = ServerConnection();
    await srvConn.getProducts(idstore).then((productsdata) {
      List<String> records = productsdata.split("|");
      for (var element in records) {
        products.add(Product.fromString(idstore+";"+element));
      }
    });
    return products;
  }


}