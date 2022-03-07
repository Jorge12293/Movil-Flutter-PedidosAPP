import 'dart:convert';

class ModelEmpresa {

  ModelEmpresa({
    required this.imagen,
    required this.nombre,
    required this.idCategoria,
    String? id
  });  
   
  String imagen;
  String nombre;
  String idCategoria;
  late String id;

  factory ModelEmpresa.fromJson(String str) => ModelEmpresa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelEmpresa.fromMap(Map<String, dynamic> json) => ModelEmpresa(
    imagen: json["imagen"],
    nombre: json["nombre"], 
    idCategoria: json["idCategoria"], 
  );

    Map<String, dynamic> toMap() => {
        "imagen": imagen,
        "nombre": nombre,
        "idCategoria": idCategoria,
    };

    ModelEmpresa copy() => ModelEmpresa(
      imagen:imagen,
      nombre:nombre,
      idCategoria:idCategoria, 
    );

}
