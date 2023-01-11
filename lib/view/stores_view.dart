import 'package:flutter/material.dart';
import 'package:mi_barrio_app/controller/db_connection.dart';
import 'package:mi_barrio_app/controller/product_controller.dart';
import 'package:mi_barrio_app/controller/store_controller.dart';
import 'package:mi_barrio_app/model/stores.dart';
import 'package:mi_barrio_app/view/products_view.dart';
import 'package:mi_barrio_app/view/shoppingcart_view.dart';


class StoresListView extends StatefulWidget {
  const StoresListView({Key? key}) : super(key: key);

  @override
  _StoresListViewState createState() => _StoresListViewState();
}

class _StoresListViewState extends State<StoresListView> {
  final stDAO = StoreDAO();
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tiendas'),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => handleTap(item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(value: 0, child: Text('Carrito de compras')),
            ],
          ),
        ],
      ),
      body: _buildStoresList(),
    );
  }

  Widget _buildStoresList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: StoreDAO.stores.length * 2 ,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider();
          /*2*/
          int index = i ~/ 2; /*3*/
          return _buildRow(StoreDAO.stores[index]);
        });
  }

  Widget _buildRow(Store st) {
    return ListTile(
      title: Text(
        st.namestore,
        style: _biggerFont,
      ),
      subtitle: Text(
        st.adresstore,
        style: const TextStyle(fontSize: 20, color: Colors.blue)
      ),
      leading: FadeInImage(
        image: NetworkImage("https://drive.google.com/uc?export=view&id="+st.logo),
        placeholder: const AssetImage("assets/jar-loading.gif"),
        fadeInDuration: const Duration(milliseconds: 180),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right, size: 20, color: Colors.blue),
      onTap: (){
        var prDao = ProductsDAO();
        prDao.getProductsFromServer(st.idstore).then((productlist) => {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductListView(st, productlist))
        ),
        });
      },
    );
  }

  void handleTap(int item) {
    switch (item) {
      case 0:
        DbManager.db.pdtTempList().then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingCartView(value))
          );
        });
        break;
    }
  }

}