import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mi_barrio_app/controller/order_controller.dart';
import 'package:mi_barrio_app/controller/store_controller.dart';
import 'package:mi_barrio_app/view/login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value){
    OrderDao.addOrdersFromServer();
    StoreDAO.addStoresFromServer().then((value) => runApp(const Login()));
  });

}
