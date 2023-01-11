import 'package:flutter/material.dart';
import 'package:mi_barrio_app/controller/db_connection.dart';
import 'package:mi_barrio_app/model/products.dart';
import 'package:mi_barrio_app/model/stores.dart';
import 'package:mi_barrio_app/view/google_maps_view.dart';
import 'package:mi_barrio_app/view/shoppingcart_view.dart';

class ProductListView extends StatefulWidget {
  final List<Product> productlist;
  final Store store;
  const ProductListView(this.store, this.productlist, {Key? key}) : super(key: key);

  @override
  _ProductsListViewState createState() => _ProductsListViewState();

}

class _ProductsListViewState extends State<ProductListView> {
  final _biggerFont = const TextStyle(fontSize: 20.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
        actions: <Widget>[
        PopupMenuButton<int>(
          onSelected: (item) => handleTap(item),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(value: 0, child: Text('Ver en google maps')),
            const PopupMenuItem<int>(value: 1, child: Text('Carrito de compras')),
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
        itemCount: widget.productlist.length * 2 ,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider();
          /*2*/
          int index = i ~/ 2; /*3*/
          return _buildRow(widget.productlist[index]);
        });
  }

  Widget _buildRow(Product pdt) {
    return ListTile(
        title: Text(
          pdt.name,
          style: _biggerFont,
        ),
        subtitle: Text(
            pdt.price.toString() + ' COP',
            style: const TextStyle(fontSize: 18.0, color: Colors.blue)
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add, size: 18.0, color: Colors.blue),
          onPressed: (){
            pdt.cant = 1;
            DbManager.db.insertNewTempOrder(pdt);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Producto agregado al carrito')),
            );
          },
        )
    );
  }

  void handleTap(int item) {
    switch (item) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GoogleMaps(widget.store))
        );
        break;
      case 1:
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