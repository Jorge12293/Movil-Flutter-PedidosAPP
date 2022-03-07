import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pedidos_appv3/models/models.dart';


class ProductsService extends ChangeNotifier{

  final String _baseUrl = 'pedidosapp-ef438-default-rtdb.firebaseio.com';

  final List<ModelProduct> products = [];
  late ModelProduct selectedProduct;

  late File newPictureFile;
  bool isLoading = true;
  bool isSaving= false;

  ProductsService(){
    loadProducts();
  }

  Future<List<ModelProduct>> loadProducts() async{
    isLoading= true;
    notifyListeners();

    final url = Uri.https(_baseUrl,'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productosMap = json.decode(resp.body);
    productosMap.forEach((key, value) {
      final temProduct = ModelProduct.fromMap(value);
      temProduct.id = key;
      products.add(temProduct);
    });

    isLoading= false;
    notifyListeners();
      
    return products;
  }

  Future saveOnCreateProduct(ModelProduct product) async{
    isSaving=true;
    notifyListeners();

    // ignore: unnecessary_null_comparison
    if(product.id==null){
      await createProduct(product);
    }else{
      await updateProduct(product);
    }


    isSaving=false;
    notifyListeners();
  }

  Future<String> updateProduct(ModelProduct product) async{
    final url = Uri.https(_baseUrl,'products/${product.id}.json');
    final resp = await http.put(url,body: product.toJson());
    final decodedData = resp.body;
    // ignore: avoid_print
    print(decodedData);

    final index = products.indexWhere((element) => element.id == product.id);
    products[index]=product;

    return product.id;
  }


  Future<String> createProduct(ModelProduct product) async{
    final url = Uri.https(_baseUrl,'products.json');
    final resp = await http.post(url,body: product.toJson());
    final decodedData = json.decode(resp.body);
    product.id=decodedData['name'];
    products.add(product);
    // ignore: avoid_print
    print(decodedData);

    
    return product.id;
  }


  void updateSelectedProductImage(String path){
    selectedProduct.imagen= path;
    newPictureFile= File.fromUri(Uri(path:path));
    notifyListeners();
  }


  Future<String?> uploadImage() async{

    // ignore: unnecessary_null_comparison
    if(newPictureFile==null) return null;

    isSaving=true;
    notifyListeners();

    final url = Uri.parse("https://api.cloudinary.com/v1_1/jorgerivera122/image/upload?upload_preset=wjbycwbi");

    final imageUploadRequest = http.MultipartRequest('POST',url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode !=200 && resp.statusCode !=201){
      // ignore: avoid_print
      print('Algo Salio Mal');
      // ignore: avoid_print
      print(resp.body);
      return null;
    }

    newPictureFile;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  
  }
}