
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pedidos_appv3/models/model_categoria_empresa.dart';

class CategoriaEmpresaService extends ChangeNotifier{

  final String _baseUrl = 'pedidosapp-ef438-default-rtdb.firebaseio.com';
  List<ModelCategoriaEmpresa> categoriaEmpresasList = [];
  bool isLoading = true;
  final storage = const FlutterSecureStorage();

  CategoriaEmpresaService(){
    loadCategoriaEmpresas();
  }

  Future<List<ModelCategoriaEmpresa>> loadCategoriaEmpresas() async{
    isLoading= true;
    notifyListeners();
    final url = Uri.https(_baseUrl,'categoriaEmpresas.json',{
      'auth': await storage.read(key: 'token') ?? ''
    });
    final resp = await http.get(url);
    final Map<String, dynamic> categoriaEmpresaMap = json.decode(resp.body);
    
    if ( categoriaEmpresaMap['error'] != null ) return [];

    categoriaEmpresaMap.forEach((key, value) {
      final temCategoriaEmpresa = ModelCategoriaEmpresa.fromMap(value);
      temCategoriaEmpresa.id=key;
      categoriaEmpresasList.add(temCategoriaEmpresa);
    });

    isLoading= false;
    notifyListeners();
    return categoriaEmpresasList;
  }
}