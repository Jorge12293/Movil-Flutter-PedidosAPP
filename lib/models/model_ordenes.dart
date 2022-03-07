
class ModelOrdenes {
    final String idCliente;
    final double total;
    final String estado;
    final String ubicacion;
    final DateTime fecha;
    final String idConductor;
    late String id;
    
    ModelOrdenes(
      this.idCliente,
      this.total,
      this.estado,
      this.ubicacion,
      this.fecha,
      this.idConductor
    );
 

  ModelOrdenes.fromJson(Map<dynamic,dynamic> json): 
    idCliente=json['idCliente'],
    total=json['total'].toDouble(),
    estado=json['estado'],
    ubicacion=json['ubicacion'],
    fecha =DateTime.parse(json['fecha'] as String),
    idConductor=json['idConductor'];


  Map<dynamic, dynamic> toJson()=> <dynamic, dynamic>{
    'idCliente':idCliente,
    'total':total,
    'estado':estado,
    'ubicacion':ubicacion,
    'fecha':fecha.toString(),
    'idConductor':idConductor,
  };  


}