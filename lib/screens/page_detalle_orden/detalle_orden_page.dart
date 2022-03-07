import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:geolocator/geolocator.dart';
import 'package:pedidos_appv3/dao/dao_orden.dart';
import 'package:pedidos_appv3/dao/dao_orden_detalle.dart';
import 'package:pedidos_appv3/models/model_ordenes.dart';
//import 'package:pedidos_appv3/models/models.dart';
import 'package:pedidos_appv3/providers/mapa_provider.dart';
import 'package:pedidos_appv3/providers/orden_detalle_provider.dart';
import 'package:pedidos_appv3/services/notifications_services.dart';
//import 'package:pedidos_appv3/services/services.dart';
import 'package:provider/provider.dart';

class DetalleOrdenPage extends StatefulWidget {
  final ordenDao = OrdenDAO();
   final ordenDetalleDao = OrdenDetalleDAO();
  @override
  _DetalleOrdenPageState createState() => _DetalleOrdenPageState();
}

class _DetalleOrdenPageState extends State<DetalleOrdenPage> {

  
  final List<String> _ubicacionList = ['Actual', 'Agregar'];
  String _ubicacionSelect = 'Actual';

  final List<String> _conductorList = ['Disponible', 'Agregar'];
  String _conductorSelect = 'Disponible';  

  @override
  Widget build(BuildContext context) {
    
    final ordenDetalleProvider = Provider.of<OrdenDetalleProvider>(context);
    //final facturaServices = Provider.of<FacturaService>(context);
    final mapaProvider = Provider.of<MapaProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:const Text("DETALLE ORDEN"),
        
        backgroundColor: Colors.black
      ),
  
      body: Container(
        color:const Color(0xff072734),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                children: <Widget>[
                  _clienteOrden(),
                  const Divider(color: Colors.white),
                  _crearDropdownUbicacion(mapaProvider,_ubicacionList),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(20),
                        topRight:Radius.circular(20),
                        bottomLeft:Radius.circular(20),
                        bottomRight:Radius.circular(20),
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        // ignore: unnecessary_null_comparison
                        child: mapaProvider.direccionEnvio == null 
                        ? const Text("SIN ASIGNAR",
                            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))
                        : Text(mapaProvider.direccionEnvio,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,))
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white),
                  _crearDropdownConductor(ordenDetalleProvider ,_conductorList),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(20),
                        topRight:Radius.circular(20),
                        bottomLeft:Radius.circular(20),
                        bottomRight:Radius.circular(20),
                      )
                    ),
                    child: Center(
                      child: ordenDetalleProvider.nombreConductor==' '
                      ?const Text("SIN ASIGNAR",
                            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))
                      :Text(ordenDetalleProvider.nombreConductor,
                            style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold))
                    ),
                  ),
                  
                  
                ],
              ),
            ),
            SafeArea(
                  bottom: true,
                  top: false,
                  left: false,
                  right: false,
                  child:Container(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Color(0xff606060),
                      borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(25),
                        topRight:Radius.circular(25),
                      )
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: double.infinity,
                          color:Colors.white,
                          child:Center(child: Text("TOTAL = ${ordenDetalleProvider.totalOrden} \$",style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ignore: sized_box_for_whitespace
                            Container(
                              height: 40,
                              //width: MediaQuery.of(context).size.width * 0.45,
                              width: 150,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20)
                                  )
                                ),
                                child: ListTile(
                                  title: const Center(child: Text("ACEPTAR",style: TextStyle(color: Colors.white))),
                                  subtitle: const Text(" "),
                                  onTap: () async{
                                    ModelOrdenes modelOrden = ModelOrdenes (
                                      '0',
                                      ordenDetalleProvider.totalOrden,
                                      'EJECUTADA',
                                      mapaProvider.direccionEnvio,
                                      DateTime.now(),
                                      ordenDetalleProvider.idConductor
                                    );
                                    String key = await widget.ordenDao.guardarOrdenes(modelOrden);
                                    await widget.ordenDetalleDao.guardarListaDetalle(key,ordenDetalleProvider.listaOrdenDetalles);
                                    //facturaServices.pocesarOrden(modelOrden,ordenDetalleProvider.listaOrdenDetalles);
                                    ordenDetalleProvider.limpiarCarrito();
                                    NotificationsServices.showSnackbar('Orden Guardada','info');
                                    await Navigator.pushNamed(context,'home');
                                 },
                                ),
                              ),
                            ),
                            // ignore: sized_box_for_whitespace
                            Container(
                              height: 40,
                              //width: MediaQuery.of(context).size.width * 0.45,
                              width: 150,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20)
                                  )
                                ),
                                child: ListTile(
                                  title: const Center(child: Text("CANCELAR",style: TextStyle(color: Colors.white))),
                                  subtitle: const Text(" "),
                                  onTap: (){
                                    Navigator.pushNamed(context,'carrito');
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  )
                )
          ],
        )
      ),
    
   );
  }


  Widget _clienteOrden () {
    return Row(children: const <Widget>[
      Icon(Icons.person,color: Colors.white),
      SizedBox(width: 30.0),
      Text("CLIENTE:",style:TextStyle(color: Colors.white)),
      SizedBox(width: 35.0),
      Text("Jorge Rivera",style:TextStyle(color: Colors.white)),
    ]);
  }

  Widget _crearDropdownUbicacion(MapaProvider mapaProvider,List<String> _listaOpciones) {
    return Row(children: <Widget>[
      const Icon(Icons.person_pin_circle,color: Colors.white),
      const SizedBox(width: 30.0),
      const Text("UBICACION:",style:TextStyle(color: Colors.white)),
      const SizedBox(width: 35.0),
      DropdownButton(
        dropdownColor: const Color(0xff606060),
        style: const TextStyle(color: Colors.white),
        value: _ubicacionSelect,
        items: getOpcionesDropdown(_listaOpciones),
        onChanged: (opt) {
          setState(() {
            _ubicacionSelect = opt.toString();
            if(_ubicacionSelect == 'Agregar'){
              Navigator.pushNamed(context,'mapaPage');
            }
            if(_ubicacionSelect == 'Actual') {
              mapaProvider.obtenerUbicacion();
            }
  
          });
        },
      ),
    ]);
  }

  Widget _crearDropdownConductor(OrdenDetalleProvider ordenDetalleProvider ,List<String> _listaOpciones) {
    return Row(children: <Widget>[
      const Icon(Icons.person_search,color: Colors.white),
      const SizedBox(width: 30.0),
      const Text("CONDUCTOR:",style:TextStyle(color: Colors.white)),
      const SizedBox(width: 30.0),
      DropdownButton(
        dropdownColor: const Color(0xff606060),
        style: const TextStyle(color: Colors.white),
        value: _conductorSelect,
        items: getOpcionesDropdown(_listaOpciones),
        onChanged: (opt) {
          setState(() {
            _conductorSelect = opt.toString();
            if(_conductorSelect == 'Agregar'){
              Navigator.pushNamed(context,'conductoresPage');
            }
            if(_conductorSelect == 'Disponible') {
              ordenDetalleProvider.idConductor=' ';
              ordenDetalleProvider.nombreConductor='DISPONIBLE';
            }
          });
        },
      ),
    ]);
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown(List<String> _listaOpciones) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<String>> lista = [];
    // ignore: avoid_function_literals_in_foreach_calls
    _listaOpciones.forEach((opcion) {
      lista.add(DropdownMenuItem(
        child: Text(opcion),
        value: opcion,
      ));
    });
    return lista;
  }

}


