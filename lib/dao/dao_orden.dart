import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pedidos_appv3/models/model_ordenes.dart';


class OrdenDAO{
 final storage = const FlutterSecureStorage();

  final DatabaseReference _ordenesRef = FirebaseDatabase.instance.reference()
        .child('ordenes');
 
  Future<String> guardarOrdenes(ModelOrdenes ordenes) async{
    String newkey = _ordenesRef.child('ordenes').push().key;
    await _ordenesRef.child(newkey).set(ordenes.toJson());
    return newkey;
  }

  Query getOrdenes() =>_ordenesRef;

  /*
  Query getOrdenes(String estado){
    if(estado=='ALL'){
      return _ordenesRef;
    }else{
      return _ordenesRef.orderByChild("estado").equalTo(estado); 
    }
  }
  */
   

}