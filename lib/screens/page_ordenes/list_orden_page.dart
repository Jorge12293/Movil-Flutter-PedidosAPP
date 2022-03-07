import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


// ignore: unused_import
import 'package:animate_do/animate_do.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pedidos_appv3/dao/dao_orden.dart';
import 'package:pedidos_appv3/dao/dao_usuarios.dart';
import 'package:pedidos_appv3/models/model_ordenes.dart';
import 'package:pedidos_appv3/models/model_usuarios.dart';
import 'package:pedidos_appv3/services/services.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// ignore: use_key_in_widget_constructors
class ListOrdenPage extends StatefulWidget {
  //const ListOrdenPage({Key? key}) : super(key: key);
  final ordenDao = OrdenDAO();

  @override
  State<ListOrdenPage> createState() => _ListOrdenPageState();
}

class _ListOrdenPageState extends State<ListOrdenPage> {
  
  final ScrollController _scrollController = ScrollController();
  
  @override
  Widget build(BuildContext context){
    
    //if(_ordenesService.isLoading) return const LoadingScreen();



  
    return Scaffold(
     backgroundColor:const Color(0xff072734),
      appBar: AppBar(
        title:const Text('Lista de Ordenes'),
        backgroundColor: Colors.black
      ),
      body:Stack(
        children: <Widget>[
          _getListaOrdenes(),
        ],
      )
   );
  }

  Widget _getListaOrdenes(){
    return FirebaseAnimatedList(
        controller: _scrollController,
        query: widget.ordenDao.getOrdenes(),
        itemBuilder: (context,snapshot,animatio,index){
        final json = snapshot.value as Map<dynamic,dynamic>;
        final orden = ModelOrdenes.fromJson(json);
        orden.id=snapshot.key!;
        return FadeInLeft(
            duration: const Duration( milliseconds: 350 ),
            child:_BotonGordo(orden)
          );
        },
      );
  }
}

class _BotonGordo extends StatelessWidget {
  final ModelOrdenes orden;
  const _BotonGordo(this.orden);

  @override
  Widget build(BuildContext context) {
    
    final ordenesDetService = Provider.of<OrdenesService>(context);
    
    IconData icon;
    Color color1;
    Color color2;
    if(orden.estado=='EJECUTADA'){
      icon=FontAwesomeIcons.fileAlt;
      color1= const Color(0xff317183);
      color2=const Color(0xff46997D);
    }else if(orden.estado=='PROCESO'){
      icon=FontAwesomeIcons.spinner;
      color1= Colors.orangeAccent;
      color2= Colors.orangeAccent;
    }else if(orden.estado=='ESPERA'){
      icon=FontAwesomeIcons.truck;
      color1= Colors.blueAccent;
      color2=Colors.blueAccent;
    }else{ //Anulada
      icon=FontAwesomeIcons.fileExcel;
      color1= Colors.redAccent;
      color2= Colors.redAccent;
    }

    return GestureDetector(
      onTap: (){
        mostrarAlert(context, ordenesDetService,orden);
      },
      child: Stack(
          children: <Widget> [
            _BotonGordoBackground(icon,color1, color2), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox( height: 140, width: 40 ),
                orden.idConductor ==' '
                  ?FaIcon( icon, color: Colors.blueAccent, size: 40 )
                  :FaIcon( icon, color: Colors.white, size: 40 ),
                const SizedBox( width: 20 ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text( "Fecha: "+DateFormat('kk:mma, dd-MM-yyyyy').format(orden.fecha).toString(), style: const TextStyle( color: Colors.white, fontSize: 18 ) ),
                      orden.ubicacion.length >=23 
                      ?Text( "Ubicacion:${orden.ubicacion.substring(0, 20)}", style: const TextStyle( color: Colors.white, fontSize: 18 ) )
                      :Text( "Ubicacion:${orden.ubicacion}", style: const TextStyle( color: Colors.white, fontSize: 18 ) ),
                      Text( "Total: ${orden.total} ", style: const TextStyle( color: Colors.white, fontSize: 18 ) ),
                      Text( "Estado: ${orden.estado}", style: const TextStyle( color: Colors.white, fontSize: 18 ) ),
                      //orden.idConductor ==' '
                      //?const Text( "Conductor: SIN ASIGNAR", style: TextStyle( color: Colors.white, fontSize: 18 ) )
                      //:Text( "Estado: ${orden.idConductor}", style: const TextStyle( color: Colors.white, fontSize: 18 ) ),
                    ],
                  )
                ),

              ],
            )
    
          ],
      ),
    );
  }
}


class _BotonGordoBackground extends StatelessWidget {
  
    final IconData icon;
    final Color color1;
    final Color color2;

  const _BotonGordoBackground( this.icon, this.color1, this.color2 );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -20,
              top: -20,
              child: FaIcon( icon, size: 150, color: Colors.white.withOpacity(0.2) )
            )
          ],
        ),
      ),
      width: double.infinity,
      height: 115,
      margin: const EdgeInsets.all( 10 ),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow( color: Colors.black.withOpacity(0.2), offset: const Offset(4,6), blurRadius: 10 ),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: <Color>[
            color1,
            color2,
          ]
        )
      ),
    );
  }



}
  void mostrarAlert(BuildContext context,OrdenesService ordenesDetService,ModelOrdenes orden){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          title: const Text('OPCIONES:', style: TextStyle(color:Colors.blueAccent )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  textStyle: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic)
                ),
                child: const Text('VER ORDEN'),
                onPressed: () async{
                  await ordenesDetService.getDetalles(orden.id);
                  Navigator.of(context).pop();  
                  Navigator.pushNamed(
                  context,
                  'verOrdenPage',
                    arguments:{ 
                      'orden': orden,
                      'detalles': ordenesDetService.ordenesDetalleList,
                    }
                  );
                },
                //onPressed: ()=> Navigator.of(context).pop(),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.redAccent,
                  textStyle: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic)
                ),
                child: const Text('   ANULAR   '),
                onPressed: ()=> Navigator.of(context).pop(),
              ),
              //FlutterLogo(size: 100.0)
            ],
          ),
          actions: [
            TextButton(
              child: const Text('CERRAR'),
              onPressed: ()=> Navigator.of(context).pop(),
            )
          ],
        );
      }
    );
  }
