import 'package:animate_do/animate_do.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pedidos_appv3/dao/dao_usuarios.dart';
import 'package:pedidos_appv3/models/model_usuarios.dart';
import 'package:pedidos_appv3/providers/orden_detalle_provider.dart';
import 'package:provider/provider.dart';

class ConductoresPage extends StatefulWidget {
  //const ConductoresPage({Key? key}) : super(key: key);
  final usuariosDao = UsuariosDAO();

  @override
  State<ConductoresPage> createState() => _ConductoresPageState();
}

class _ConductoresPageState extends State<ConductoresPage> {

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff072734),
      appBar: AppBar(
        title:const Text('Lista de Conductores'),
        backgroundColor: Colors.black
      ),
      body:Stack(
        children: <Widget>[
          _getListaUuarios(),
        ],
      ) 
    );





  }

    Widget _getListaUuarios(){
    return FirebaseAnimatedList(
        controller: _scrollController,
        query: widget.usuariosDao.getUsuarios(),
        itemBuilder: (context,snapshot,animatio,index){
        final json = snapshot.value as Map<dynamic,dynamic>;
        final usuario = ModelUsuarios.fromJson(json);
        usuario.id=snapshot.key!;
        return FadeInLeft(
            duration: const Duration( milliseconds: 350 ),
            child:_CardConductores(usuario)
          );
        },
      );
  }



}

class _CardConductores extends StatelessWidget {
  final ModelUsuarios usuario;

  const _CardConductores(this.usuario) ;

  @override
  Widget build(BuildContext context) {

    final ordenDetalleProvider = Provider.of<OrdenDetalleProvider>(context);
    
    List<Widget> listaEstrellas=[];

    for (var i = 0 ; i < 5; i++) {

      if(i < (usuario.calificacion / usuario.votantes) ){
        listaEstrellas.add(const Icon(Icons.star,size: 30,color: Colors.yellow));
      }else{
        listaEstrellas.add(const Icon(Icons.star,size: 30,color: Color(0xff545454)));
      }
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: MaterialButton(
            elevation: 0,
            onPressed: (){

              ordenDetalleProvider.idConductor=usuario.id;
              ordenDetalleProvider.nombreConductor=usuario.nombre+" "+usuario.apellido;
              Navigator.of(context).pop();
              //print(usuario.id);
            },
            color:usuario.estado=='OCUPADO'
                  ?Colors.redAccent.withOpacity(0.7)
                  :const Color(0xff02d39a).withOpacity(0.7),
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical:5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            child: Row(
              children:  [
                const CircleAvatar(
                  radius: 40,
                  child:Icon(
                    Icons.person_sharp,
                    size: 70,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(usuario.nombre +" "+ usuario.apellido, style: const TextStyle(color: Colors.white, fontSize: 20)),
                    Text("Entregas: ${usuario.votantes}", style: const TextStyle(color: Colors.white, fontSize: 15)),
                    Text(usuario.estado, style: const TextStyle(color: Colors.white, fontSize: 15)),
                    Row(
                      children: [
                
                        listaEstrellas[0],
                        listaEstrellas[1],
                        listaEstrellas[2],
                        listaEstrellas[3],
                        listaEstrellas[4],
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}