import 'package:flutter/material.dart';
import 'package:mi_barrio_app/controller/db_connection.dart';
import 'package:mi_barrio_app/model/products.dart';
import 'package:mi_barrio_app/view/order_confirmation.dart';


class ShoppingCartView extends StatefulWidget {
  final List<Product> orderlist;
  const ShoppingCartView(this.orderlist, {Key? key}) : super(key: key);

  @override
  _ShoppingCartViewState createState() => _ShoppingCartViewState();

}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  final _biggerFont = const TextStyle(fontSize: 20.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: _buildOrderList(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Confirmar Pedido"),
        icon: const Icon(Icons.done),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderConfirmation(widget.orderlist))
            );
          },
          
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.orderlist.length * 2 ,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider();
          /*2*/
          int index = i ~/ 2; /*3*/
          return _buildRow(widget.orderlist[index]);
        });
  }

  Widget _buildRow(Product pdt) {
    return ListTile(
        title: Text(
          pdt.name,
          style: _biggerFont,
        ),
        subtitle: Text(
            'Cantidad: ' + pdt.cant.toString(),
            style: const TextStyle(fontSize: 18.0, color: Colors.blue)
        ),
      trailing: IconButton(
        onPressed: (){
          DbManager.db.deleteTempOrder(pdt);
        },
        icon: const Icon(Icons.remove),
      ),
    );
  }

}