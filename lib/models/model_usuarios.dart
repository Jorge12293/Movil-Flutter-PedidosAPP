
class ModelUsuarios {
    final String apellido;
    final int calificacion;
    final String correo;
    final String estado;
    final String nombre;
    final String password;
    final String telefono;
    final String tipo;
    final int votantes;
    late String id;
    
    ModelUsuarios(
      this.apellido,
      this.calificacion,
      this.correo,
      this.estado,
      this.nombre,
      this.password,
      this.telefono,
      this.tipo,
      this.votantes,
    );
 

  ModelUsuarios.fromJson(Map<dynamic,dynamic> json):
    apellido=json['apellido'],
    calificacion=json['calificacion'],
    correo=json['correo'],
    estado=json['estado'],
    nombre=json['nombre'],
    password=json['password'],
    telefono=json['telefono'],
    tipo=json['tipo'],
    votantes=json['votantes'];

  Map<dynamic, dynamic> toJson()=> <dynamic, dynamic>{
      'apellido':apellido,
      'calificacion':calificacion,
      'correo':correo,
      'estado':estado,
      'nombre':nombre,
      'password':password,
      'telefono':telefono,
      'tipo':tipo,
      'votantes':votantes,
  }; 

  factory ModelUsuarios.fromMap(Map<String, dynamic> json) => ModelUsuarios(
    json['apellido'],
    json['calificacion'],
    json['correo'],
    json['estado'],
    json['nombre'],
    json['password'],
    json['telefono'],
    json['tipo'],
    json['votantes']
  );   


}