import 'dart:convert';

class ModelProducto {
    ModelProducto({
      required this.empresa,
      required this.imagen,
      required this.nombre,
      required this.precio,
      String? id,
    });

    String empresa;
    String imagen;
    String nombre;
    double precio;
    late String id;

    factory ModelProducto.fromJson(String str) => ModelProducto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelProducto.fromMap(Map<String, dynamic> json) => ModelProducto(
        empresa:json["empresa"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        precio: json["precio"].toDouble(),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "empresa": empresa,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
    };

    ModelProducto copy() => ModelProducto(
      empresa:empresa,
      imagen:imagen,
      nombre:nombre,
      precio:precio,
      id:id,
    );
}
