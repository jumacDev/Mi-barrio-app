import 'package:flutter/material.dart';
import 'package:mi_barrio_app/controller/db_connection.dart';
import 'dart:math';
import 'package:mi_barrio_app/controller/server_connection.dart';
import 'package:mi_barrio_app/model/products.dart';
import 'package:mi_barrio_app/view/home_view.dart';

class OrderConfirmation extends StatefulWidget{


  final List<Product> productlist;
  const OrderConfirmation(this.productlist, {Key? key}) : super(key: key);

  @override
  _OrderConfirmationState createState() {
    return _OrderConfirmationState();
  }
}

class _OrderConfirmationState extends State<OrderConfirmation>{
  final _biggerFont = const TextStyle(fontSize: 21.0, color: Colors.black);
  String data = '';
  var totalprice = 0;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Resumen del Pedido'),
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (item) => handleTap(item),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(value: 0, child: Text('Cancelar Pedido')),
              ],
            ),
          ],
        ),
        body: _buildOrderResumList(),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Finalizar', style: TextStyle(fontSize: 18.0)),
          icon: const Icon(Icons.check_circle),
          onPressed: (){
            _showConfirmationDialog();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      );
  }

  Widget _buildOrderResumList() {
    return ListView.builder(
      padding: const EdgeInsets.all(14.0),
      itemCount: widget.productlist.length * 2 ,
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider();
          /*2*/
          int index = i ~/ 2; /*3*/
          totalprice += widget.productlist[index].price * widget.productlist[index].cant;
          return _buildRow(widget.productlist[index]);
      }
      );
  }

  Widget _buildRow(Product pdt) {
    data = data + pdt.name+','+pdt.price.toString()+','+pdt.cant.toString()+'|';
    return ListTile(
        title: Text(
          pdt.name,
          style: _biggerFont,
        ),
        subtitle: Text(
            'Cantidad: '+pdt.cant.toString()+'  Precio: '+pdt.price.toString(),
            style: const TextStyle(fontSize: 18.0, color: Colors.blue)
        ),
      trailing: const Icon(Icons.receipt),
    );
  }

  void handleTap(int item) {
    switch (item) {
      case 0:
        _showMyDialog();
        break;
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mi barrio', style: TextStyle(fontSize: 22.0, color: Colors.blue),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Cancelar el pedido'),
                Text('¿Seguro desea cancelar el pedido?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No',style: TextStyle(fontSize: 15.0, color: Colors.blue),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Si',style: TextStyle(fontSize: 15.0, color: Colors.blue),),
              onPressed: () {
                DbManager.db.deleteTempList().then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pedido Cancelado')),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView())
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mi barrio', style: TextStyle(fontSize: 22.0, color: Colors.blue),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Confirme el pedido'),
                Text('Precio total: ' + totalprice.toString() + ' COP' ),
                const Text('¿Seguro desea finalizar el pedido?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No',style: TextStyle(fontSize: 15.0, color: Colors.blue),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Si',style: TextStyle(fontSize: 15.0, color: Colors.blue),),
              onPressed: () {
                var idorder = (Random());
                var srvcon = ServerConnection();
                srvcon.insert('Orders', idorder.nextInt(1000).toString()+';'+data).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pedido Finalizado, ¡Gracias por tu compra!')),
                  );
                });
                DbManager.db.deleteTempList().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView())
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }


}

