import 'dart:convert';

class ModelOrden {
    ModelOrden({
      required this.idCliente,
      required this.total,
      required this.estado,
      required this.fecha,
      String? id,
    });

    String idCliente;
    double total;
    String estado;
    String fecha;
    late String id;

    factory ModelOrden.fromJson(String str) => ModelOrden.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModelOrden.fromMap(Map<String, dynamic> json) => ModelOrden(
        idCliente: json["idCliente"],
        total: json["total"].toDouble(),
        estado: json["estado"],
        fecha: json["fecha"]
    );

    Map<String, dynamic> toMap() => {
        "idCliente": idCliente,
        "total": total,
        "estado": estado,
        "fecha": fecha
    };

    ModelOrden copy() => ModelOrden(
      idCliente:idCliente,
      total:total,
      estado:estado,
      fecha:fecha
    );
}