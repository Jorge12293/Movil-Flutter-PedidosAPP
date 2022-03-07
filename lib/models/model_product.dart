import 'dart:convert';

class ModelProduct {
    ModelProduct({
        estado,
        imagen,
        nombre,
        precio,
        id
    });

    late bool estado;
    late String imagen;
    late String nombre;
    late double precio;
    late String id;

    factory ModelProduct.fromJson(String str) => ModelProduct.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelProduct.fromMap(Map<String, dynamic> json) => ModelProduct(
        estado: json["estado"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        precio: json["precio"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "estado": estado,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
    };

    ModelProduct copy() => ModelProduct(
      estado:estado,
      imagen:imagen,
      nombre:nombre,
      precio:precio,
      id:id,
    );
}
