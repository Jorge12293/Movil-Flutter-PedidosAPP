import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedidos_appv3/models/model_ordenes.dart';
import 'package:pedidos_appv3/models/model_ordenes_detalle.dart';
import 'dart:convert';

import 'package:pedidos_appv3/models/models.dart';

class OrdenesService extends ChangeNotifier{

  final String _baseUrl = 'pedidosapp-ef438-default-rtdb.firebaseio.com';
  final List<ModelOrdenes> ordenesList = [];
  final List<ModelOrdenesDetalle> ordenesDetalleList = [];
  bool isLoading = true;
  String idOrden="";

  OrdenesService();

  Future<List<ModelOrdenesDetalle>> getDetalles(String id) async{
    
    ordenesDetalleList.clear();
    idOrden=id;
    isLoading= true;
    notifyListeners();

    const _path = "ordenesDetalles.json";
    final _params = {'orderBy': '"idOrden"','equalTo': '"$idOrden"','print': 'print'};
    final url = Uri.https(_baseUrl,_path,_params);
    final resp = await http.get(url);
    final Map<String, dynamic> detallesMap = json.decode(resp.body);

    detallesMap.forEach((key, value) {
      final temDetalle = ModelOrdenesDetalle.fromMap(value);
      ordenesDetalleList.add(temDetalle);
    });

    isLoading= false;
    notifyListeners();
    // ignore: avoid_print
    print(ordenesDetalleList);
    return ordenesDetalleList;
  }

}