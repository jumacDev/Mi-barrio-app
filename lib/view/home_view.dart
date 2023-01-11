import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mi_barrio_app/controller/order_controller.dart';
import 'package:mi_barrio_app/view/login.dart';
import 'package:mi_barrio_app/view/order_view.dart';
import 'package:mi_barrio_app/view/stores_view.dart';
import 'package:mi_barrio_app/view/suggestions_view.dart';
import 'form_view.dart';


class HomeView extends StatefulWidget{
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() {
    return HomeViewState();
  }

}


class HomeViewState extends State<HomeView> {

  final List<String> images = [
    "assets/client_register.png",
    "assets/generate.png",
    "assets/stores_list.png",
    "assets/suggests.png"
  ];

  @override
  Widget build(BuildContext context) {
    OrderDao.addOrdersFromServer();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Mi Barrio"),
              centerTitle: true,
              backgroundColor: Colors.blueAccent,
              actions: <Widget>[
                PopupMenuButton<int>(
                  onSelected: (item) => handleTap(item),
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(value: 0, child: Text('Cerrar sesión')),
                  ],
                ),
              ],
            ),
            body: Container(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 10.0
                    ),
                    itemBuilder: (context, int index) => buildCell(context, index),
                ))
        ),
    );
  }
  Widget buildCell(BuildContext context, int index){
     return GestureDetector(
      onTap: (){
        _navigateTo(context, index);
      },
      child: Image.asset(
        images[index],
        fit: BoxFit.cover,
        width: 90.0,
        height: 90.0,
      ),
    );
  }

  _navigateTo(BuildContext context, int index){
    if(index == 0){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FormPage())
      );
    }else if(index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrderListView())
      );

    }else if(index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StoresListView())
      );
    }else if(index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SuggestionsForm())
      );
    }
  }

  void handleTap(int item) {
    switch (item) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login())
        );
        break;
    }
  }

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen(
          (message) {
        if (message.notification != null) {
          print(message.notification!.body);
          print(message.notification!.title);
        }
        //LocalNotificationService.display(message);
        print(message);
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
          (messagge) {
        final routeMessagge = messagge.data["route"];
        print(routeMessagge);
        Navigator.of(context).pushNamed(routeMessagge);
      },
    );
    super.initState();
  }


}
