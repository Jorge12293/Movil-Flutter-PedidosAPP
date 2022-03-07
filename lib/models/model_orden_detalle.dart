import 'dart:convert';

class ModelOrdenDetalle {

    ModelOrdenDetalle({
      required this.imagen,
      required this.cantidad,
      required this.descripcion,
      String? idOrden,
      required this.idProducto,
      required this.precio,
      required this.total,
    });

    String imagen;
    int cantidad;
    String descripcion;
    late String idOrden;
    String idProducto;
    double precio;
    double total;


    factory ModelOrdenDetalle.fromJson(String str) => ModelOrdenDetalle.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelOrdenDetalle.fromMap(Map<String, dynamic> json) => ModelOrdenDetalle(
        imagen:json["imagen"],
        cantidad:json["cantidad"],
        descripcion:json["descripcion"],
        idOrden:json["idOrden"],
        idProducto:json["idProducto"],
        precio:json["precio"],
        total:json["total"]
    );

    Map<String, dynamic> toMap() => {
        "imagen":imagen,
        "cantidad":cantidad,
        "descripcion":descripcion,
        "idOrden":idOrden,
        "idProducto":idProducto,
        "precio":precio,
        "total":total
    };

    ModelOrdenDetalle copy() => ModelOrdenDetalle(
      imagen:imagen,
      cantidad:cantidad,
      descripcion:descripcion,
      idOrden:idOrden,
      idProducto:idProducto,
      precio:precio,
      total:total
    );
}