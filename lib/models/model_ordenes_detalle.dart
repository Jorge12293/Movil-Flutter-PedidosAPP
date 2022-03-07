class ModelOrdenesDetalle {
    
    int cantidad;
    String descripcion;
    String idProducto;
    String imagen;
    double precio;
    double total;
    late String idOrden;    

    ModelOrdenesDetalle(
      this.cantidad,
      this.descripcion,
      this.idProducto,
      this.imagen,
      this.precio,
      this.total,
    );


  ModelOrdenesDetalle.fromJson(Map<dynamic,dynamic> json): 
    cantidad=int.parse(json["cantidad"]),
    descripcion=json["descripcion"],
    idOrden=json["idOrden"],
    idProducto=json["idProducto"],
    imagen=json["imagen"],
    precio=json["precio"].toDouble(),
    total=json["total"].toDouble();


  Map<dynamic, dynamic> toJson()=> <dynamic, dynamic>{
    "cantidad":cantidad,
    "descripcion":descripcion,
    "idOrden":idOrden,
    "idProducto":idProducto,
    "imagen":imagen,
    "precio":precio,
    "total":total
  };

  factory ModelOrdenesDetalle.fromMap(Map<String, dynamic> json) => ModelOrdenesDetalle(
    int.parse(json["cantidad"].toString()),
    json["descripcion"],
    json["idProducto"],
    json["imagen"],
    json["precio"].toDouble(),
    json["total"].toDouble()
  );  

}