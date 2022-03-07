import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedidos_appv3/thmes/map_theme.dart';
import 'package:geocoding/geocoding.dart';

class MapaProvider extends ChangeNotifier{
  
  late GoogleMapController _mapController;
  bool _mapaListo = false;
  LatLng _ubicacionCentral = const LatLng(0, 0);
  String _direccionEnvio='';


  String get direccionEnvio => _direccionEnvio;
  set direccionEnvio(String value){
    _direccionEnvio = value;
    notifyListeners();
  }

  GoogleMapController get mapController=> _mapController;
  set mapController(GoogleMapController value){
    _mapController = value;
    notifyListeners();
  }

  LatLng get ubicacionCentral=> _ubicacionCentral;
  set ubicacionCentral(LatLng value){
    _ubicacionCentral = value;
    actualizarUbicacion(_ubicacionCentral);
    notifyListeners();
  }

  bool get mapaListo=> _mapaListo;
  set mapaListo(bool value){
    _mapaListo = value;
    notifyListeners();
  }

  void initMapa(GoogleMapController controller){
    if(!_mapaListo){
      _mapController=controller;
      _mapController.setMapStyle(
        jsonEncode(mapThemeDark)
      );
      _mapaListo=true; 
    }else{
      _mapController=controller;
      _mapController.setMapStyle(
        jsonEncode(mapThemeDark)
      );
    }

    notifyListeners();
  }

 void actualizarUbicacion(LatLng ubicacion) async {
    
   // Geolocator _geolocator = Geolocator();
    String latitude = "";
    String longitude = "";
    String address = "";
    /*
    Position position = await _geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best);///Here you have choose level of distance
    latitude = position.latitude.toString() ?? '';
    longitude = position.longitude.toString() ?? '';
    */
    var placemarks = await placemarkFromCoordinates(ubicacion.latitude, ubicacion.longitude);
     address ='${placemarks.first.name!.isNotEmpty ? placemarks.first.name! + ', ' : ''}${placemarks.first.thoroughfare!.isNotEmpty ? placemarks.first.thoroughfare! + ', ' : ''}${placemarks.first.subLocality!.isNotEmpty ? placemarks.first.subLocality!+ ', ' : ''}${placemarks.first.locality!.isNotEmpty ? placemarks.first.locality!+ ', ' : ''}${placemarks.first.subAdministrativeArea!.isNotEmpty ? placemarks.first.subAdministrativeArea! + ', ' : ''}${placemarks.first.postalCode!.isNotEmpty ? placemarks.first.postalCode! + ', ' : ''}${placemarks.first.administrativeArea!.isNotEmpty ? placemarks.first.administrativeArea : ''}';
    // ignore: avoid_print
    print("latitude $latitude");
    // ignore: avoid_print
    print("longitude"+longitude);
    // ignore: avoid_print
    print("adreess"+address);
    direccionEnvio=address;
    //print(this.direccionEnvio);
    notifyListeners();
  }


 void obtenerUbicacion() async {
   // Geolocator _geolocator = Geolocator();
    String latitude = "";
    String longitude = "";
    String address = "";
    
    Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best);///Here you have choose level of distance
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    address ='${placemarks.first.name!.isNotEmpty ? placemarks.first.name! + ', ' : ''}${placemarks.first.thoroughfare!.isNotEmpty ? placemarks.first.thoroughfare! + ', ' : ''}${placemarks.first.subLocality!.isNotEmpty ? placemarks.first.subLocality!+ ', ' : ''}${placemarks.first.locality!.isNotEmpty ? placemarks.first.locality!+ ', ' : ''}${placemarks.first.subAdministrativeArea!.isNotEmpty ? placemarks.first.subAdministrativeArea! + ', ' : ''}${placemarks.first.postalCode!.isNotEmpty ? placemarks.first.postalCode! + ', ' : ''}${placemarks.first.administrativeArea!.isNotEmpty ? placemarks.first.administrativeArea : ''}';
    // ignore: avoid_print
    print("latitude"+latitude);
    // ignore: avoid_print
    print("longitude"+longitude);
    // ignore: avoid_print
    print("adreess se mueve "+address);
    _direccionEnvio=address;
    notifyListeners();
  }
  

}