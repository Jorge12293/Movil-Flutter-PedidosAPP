import 'package:firebase_database/firebase_database.dart';
import 'package:pedidos_appv3/models/model_ordenes_detalle.dart';


class OrdenDetalleDAO{

  final DatabaseReference _ordenDetRef = FirebaseDatabase.instance.reference()
        .child('ordenesDetalles');


  Future<String> guardarListaDetalle(String key,List<ModelOrdenesDetalle> ordenesDetalleList) async{
    for (var element in ordenesDetalleList) {
      element.idOrden=key;
      await guardarDetalle(element);
    }
    return "ok";
  }

  Future<String> guardarDetalle(ModelOrdenesDetalle ordenesDet) async{
    await _ordenDetRef.push().set(ordenesDet.toJson());
    String key = _ordenDetRef.child("ordenesDetalles").push().key; 
    return key;
  }

  Query getOrdenesDetall()=>_ordenDetRef;
  

}