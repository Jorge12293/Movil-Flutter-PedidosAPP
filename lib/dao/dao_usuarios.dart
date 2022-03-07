import 'package:firebase_database/firebase_database.dart';


class UsuariosDAO{


  final DatabaseReference _usuariosRef = FirebaseDatabase.instance.reference()
        .child('usuarios');
  /*
  Future<String> guardarOrdenes(ModelUsuarios ordenes) async{
    String newkey = _ordenesRef.child('ordenes').push().key;
    await _ordenesRef.child(newkey).set(ordenes.toJson());
    return newkey;
  }
  */
Query getUsuarios()=>_usuariosRef; 

 



}

