import 'package:flutter/material.dart';
import 'package:pedidos_appv3/models/model_product.dart';

class ProductFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ModelProduct product;

  ProductFormProvider(this.product);

  updateEstado(bool value){
    product.estado=value;
    notifyListeners();
  }


  bool isValidForm(){
    // ignore: avoid_print
    print(product.nombre);
    // ignore: avoid_print
    print('${product.precio}');
    return formKey.currentState?.validate() ?? false;
  }

}