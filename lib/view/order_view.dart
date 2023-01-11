import 'package:flutter/material.dart';
import 'package:mi_barrio_app/controller/order_controller.dart';
import 'package:mi_barrio_app/model/order.dart';
import 'package:mi_barrio_app/view/orderproduct_view.dart';


class OrderListView extends StatefulWidget {
  const OrderListView({Key? key}) : super(key: key);

  @override
  _OrderListViewState createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  final ordDao = OrderDao();
  final _biggerFont = const TextStyle(fontSize: 20.0, color: Colors.black);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pedidos'),
      ),
      body: _buildStoresList(),
  );
  }

  Widget _buildStoresList() {
    return ListView.builder(
        padding: const EdgeInsets.all(14.0),
        itemCount: OrderDao.orderslist.length * 2,
        itemBuilder:
        (context, i) {
          if (i.isOdd) return const Divider();
          int index = i ~/ 2;
          return _buildRow(OrderDao.orderslist[index]);
        });
  }

  Widget _buildRow(Order ord) {
    return ListTile(
      isThreeLine: true,
      title: Text(
        'Compra: '+ord.id.toString(),
        style: _biggerFont,
      ),
      subtitle: const Text(''),
      trailing: const Icon(Icons.keyboard_arrow_right, size: 18, color: Colors.blue),
      onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductOrderView(ord.productlist))
          );
      },
    );
  }

}