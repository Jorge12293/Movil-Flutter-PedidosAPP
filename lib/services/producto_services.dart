//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pedidos_appv3/models/models.dart';

//import 'package:pedidos_app/models/models.dart';


class ProductoService extends ChangeNotifier{
  final String _baseUrl = 'pedidosapp-ef438-default-rtdb.firebaseio.com';
  final List<ModelProducto> productos = [];
  bool isLoading = true;
  String empresa="";

  ProductoService(String empresa){
    getProductos(empresa);
  }

  Future<List<ModelProducto>> loadProductos() async{
    isLoading= true;
    notifyListeners();

    final url = Uri.https(_baseUrl,'productos.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productosMap = json.decode(resp.body);
 
    productosMap.forEach((key, value) {
      final temProducto = ModelProducto.fromMap(value);
      temProducto.id=key;
      productos.add(temProducto);
    });

    isLoading= false;
    notifyListeners();
    return productos;
  }

  Future<List<ModelProducto>> getProductos(String empresa) async{
    empresa=empresa;
    isLoading= true;
    notifyListeners();

    const _path = "productos.json";
    final _params = {'orderBy': '"empresa"','equalTo': '"$empresa"','print': 'print'};
    final url = Uri.https(_baseUrl,_path,_params);
    

    final resp = await http.get(url);

    final Map<String, dynamic> productosMap = json.decode(resp.body);

    if ( productosMap['error'] != null ) return [];
    
    productosMap.forEach((key, value) {
      final temProducto = ModelProducto.fromMap(value);
      temProducto.id=key;
      productos.add(temProducto);
    });

    isLoading= false;
    notifyListeners();
    return productos;
  }

}