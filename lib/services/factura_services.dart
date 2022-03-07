import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pedidos_appv3/models/models.dart';


class FacturaService extends ChangeNotifier{

  final String _baseUrl = 'pedidosapp-ef438-default-rtdb.firebaseio.com';
  final List<ModelOrden> ordenesList = [];
  late ModelOrden selectedOrden;
  bool isLoading = true;
  String idOrden="SN";

  FacturaService(){
    loadOrdenes();
  }

  // Lista de Ordenes
  Future<List<ModelOrden>> loadOrdenes() async{
    isLoading= true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'ordenes.json');
    final resp = await http.get(url);
    final Map<String, dynamic> ordenesMap = json.decode(resp.body);
    ordenesMap.forEach((key, value) {
      final temOrden = ModelOrden.fromMap(value);
      temOrden.id = key;
      ordenesList.add(temOrden);
    });

    isLoading= false;
    notifyListeners();
    return ordenesList;
  }

  // Procesar la orden 
  Future<String> pocesarOrden(ModelOrden orden,List<ModelOrdenDetalle> ordenDetallesList) async{
    await createOrden(orden);
    await procesarOrdenDetalle(ordenDetallesList);
    return "CODIGO1";
  }


  // CREAR ORDEN
  Future<String> createOrden(ModelOrden orden) async{
    //DATOS A MODIFICAR LUEGO
    
    // ignore: unnecessary_new
    DateTime now = new DateTime.now();
    DateFormat newFormat = DateFormat("d/M/y").add_jm();

    orden.estado="PROCESO";
    orden.fecha=newFormat.format(now);

    final url = Uri.https(_baseUrl,'ordenes.json');
    final resp = await http.post(url,body: orden.toJson());
    final decodedData = json.decode(resp.body);
    orden.id=decodedData['name'];
    ordenesList.add(orden);
    
    notifyListeners();
    idOrden=orden.id;
    return orden.id;
  }


  Future<String> procesarOrdenDetalle(List<ModelOrdenDetalle> ordenesList) async{
    // ignore: avoid_function_literals_in_foreach_calls
    ordenesList.forEach((element) {
      createOrdenDetalle(element);
    });
    return "CODIGO1";
  }

  Future<String> createOrdenDetalle(ModelOrdenDetalle ordenDetalle) async{
    ordenDetalle.idOrden=idOrden;
    final url = Uri.https(_baseUrl,'ordenesDetalles.json');
    final resp = await http.post(url,body: ordenDetalle.toJson());
    final decodedData = json.decode(resp.body);

    // ignore: avoid_print
    print(decodedData);
    return decodedData['name'];
  }




}