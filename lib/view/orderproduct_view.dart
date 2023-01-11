import 'package:flutter/material.dart';
import 'package:mi_barrio_app/model/products.dart';

class ProductOrderView extends StatefulWidget {
final List<Product> productlist;

const ProductOrderView( this.productlist, {Key? key}) : super(key: key);

@override
_ProductsOrderViewState createState() => _ProductsOrderViewState();

}

class _ProductsOrderViewState extends State<ProductOrderView> {
  final _biggerFont = const TextStyle(fontSize: 20.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
      ),
      body: _buildStoresList(),
    );
  }

  Widget _buildStoresList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.productlist.length * 2,
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
        trailing: const Icon(Icons.receipt)
    );
  }

}