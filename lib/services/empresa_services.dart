//import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pedidos_appv3/models/models.dart';

class EmpresaService extends ChangeNotifier{
  
  final String _baseUrl = 'pedidosapp-ef438-default-rtdb.firebaseio.com';
  List<ModelEmpresa> empresas = [];
  List<ModelEmpresa> empresasTemp = [];
  bool isLoading = true;
  bool _filtroCategoria = false;
  String _idSelectCategoria = " ";
  final storage = const FlutterSecureStorage();

  EmpresaService(){
    loadEmpresas();
  }

  bool get filtroCategoria=> _filtroCategoria;
  set filtroCategoria(bool value){
    _filtroCategoria = value;
    notifyListeners();
  }

  String get idSelectCategoria=> _idSelectCategoria;
  set idSelectCategoria(String value){
    _idSelectCategoria = value;
    notifyListeners();
  }

  Future<List<ModelEmpresa>> loadEmpresas() async{
    isLoading= true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'empresas.json',{
      'auth': await storage.read(key: 'token') ?? ''
    });
    final resp = await http.get(url);
    final Map<String, dynamic> empresasMap = json.decode(resp.body);
    
    if ( empresasMap['error'] != null ) return [];

    empresasMap.forEach((key, value) {
      final temEmpresa = ModelEmpresa.fromMap(value);
      temEmpresa.id=key;
      empresas.add(temEmpresa);
    });

    isLoading= false;
    empresasTemp =List.from(empresas);
    notifyListeners();
    return empresasTemp;
  }

  void eliminarFiltro(){
    _filtroCategoria = false;
    _idSelectCategoria = " ";
    empresas =List.from(empresasTemp);
    notifyListeners();
  }

  void filtrarCategoria(String idCategoria){
    _idSelectCategoria = idCategoria;
    _filtroCategoria = true;
    empresas =List.from(empresasTemp);
    empresas.removeWhere((item) => item.idCategoria != idCategoria);

    notifyListeners();

  }





/*
  Future<List<ModelEmpresa>> loadEmpresas2() async{
    isLoading= true;
    notifyListeners();

    //final _authority = "example.com";
    const _path = "empresas.json";
    final _params = {'orderBy': '"nombre"','equalTo': '"MOVISTAR"','print': 'print'};
      //final url = Uri.https(_baseUrl,'empresas.json?orderBy="nombre"&equalTo="MOVISTAR"&print=pretty');
    final url = Uri.https(_baseUrl,_path,_params);
  

    final resp = await http.get(url);

    final Map<String, dynamic> empresasMap = json.decode(resp.body);

    empresasMap.forEach((key, value) {
      final temEmpresa = ModelEmpresa.fromMap(value);
      temEmpresa.id=key;
      empresas.add(temEmpresa);
    });

    isLoading= false;
    notifyListeners();
 
   // print(empresas[0].nombre); 
    return empresas;
  }
*/
}