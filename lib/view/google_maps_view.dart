import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mi_barrio_app/model/stores.dart';

class GoogleMaps extends StatelessWidget {
  final Store store;
  const GoogleMaps(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Ubicación"),
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: GoogleMapsView(store),
      )
    );
  }
}

class GoogleMapsView extends StatefulWidget {
  final Store store;
  const GoogleMapsView(this.store,{Key? key}) : super(key: key);

  @override
  State<GoogleMapsView> createState() => GoogleMapsViewState();
}

class GoogleMapsViewState extends State<GoogleMapsView> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(widget.store.latitude, widget.store.longitude),
      zoom: 20,
    );
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: {
          Marker(
              markerId: MarkerId(widget.store.namestore),
              position: LatLng(widget.store.latitude, widget.store.longitude),
              infoWindow: InfoWindow(title: widget.store.namestore))
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

    );
  }

}