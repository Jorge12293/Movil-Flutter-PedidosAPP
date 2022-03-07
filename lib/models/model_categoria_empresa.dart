import 'dart:convert';

class ModelCategoriaEmpresa {

  ModelCategoriaEmpresa({
    required this.descripcion,
    String? id
  });  
   
  String descripcion;
  late String id;

  factory ModelCategoriaEmpresa.fromJson(String str) => ModelCategoriaEmpresa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelCategoriaEmpresa.fromMap(Map<String, dynamic> json) => ModelCategoriaEmpresa(
    descripcion: json["descripcion"],
  );

    Map<String, dynamic> toMap() => {
        "descripcion": descripcion,
    };

    ModelCategoriaEmpresa copy() => ModelCategoriaEmpresa(
      descripcion:descripcion,
    );

}
