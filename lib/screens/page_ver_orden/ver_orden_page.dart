import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pedidos_appv3/models/model_ordenes.dart';
import 'package:pedidos_appv3/models/model_ordenes_detalle.dart';
import 'package:pedidos_appv3/providers/mapa_provider.dart';
import 'package:provider/provider.dart';

class VerOrdenPage extends StatelessWidget {

  const VerOrdenPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final mapaProvider = Provider.of<MapaProvider>(context);

    ModelOrdenes modelOrden;
    List<ModelOrdenesDetalle> ordenesDetalleList = [];
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    modelOrden=arguments['orden'];
    ordenesDetalleList=arguments['detalles'];
    return Scaffold(
      backgroundColor: const Color(0xff072734),
      appBar: AppBar(
        title:const Text('Detalle de Orden'),
        backgroundColor: Colors.black
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innetIsScrolled){
          return[
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(05.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            const Text("FECHA: ",style:TextStyle(color: Colors.white,fontSize: 20)),
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(25))
                              ),
                              child: Text(DateFormat('kk:mma, dd-MM-yyyyy').format(modelOrden.fecha).toString(), style: const TextStyle(color: Colors.black,fontSize: 20)),
                            ),                     
                            const Text("DIRECCION: ",style:TextStyle(color: Colors.white,fontSize: 20)),
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(25))
                              ),
                              child: Text(modelOrden.ubicacion,style:const TextStyle(color: Colors.black,fontSize: 20)),
                            ),
                            const Text("UBICACION: ",style:TextStyle(color: Colors.white,fontSize: 20)),
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              height: 200,
                              width: 400,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.all(Radius.circular(25))
                              ),
                              child: crearMapa(mapaProvider)
                            ),
                             
                        ],
                        ),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: const <Widget>[  
                    _ItemFactura("ID",0.10,Color(0xff545454)), 
                    _ItemFactura("DESCRIPCION",0.45,Color(0xff545454)), 
                    _ItemFactura("CANT",0.15,Color(0xff545454)),
                    _ItemFactura("PU",0.15,Color(0xff545454)),
                    _ItemFactura("TOTAL",0.15,Color(0xff545454)), 
                  ]
                )
              ),
              Expanded(
                child:ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context,i)=>const Divider(                  
                    color: Colors.blue,
                    thickness:3,
                    height:3,
                  ),
                  itemCount: ordenesDetalleList.length,
                  itemBuilder: (context, int index)=>ItemFilaFactura(index+1,ordenesDetalleList[index]),
                ),
              ),
              const Divider(
                color: Colors.white,
                height: 2.0,
              ),
              Container(
  
                padding: const EdgeInsets.all(10),
                color: Color(0xff545454),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Subtotal: ",style:const TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                        Text(modelOrden.total.toString(),style:const TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Transporte: ",style:const TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                        Text("0",style:const TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      
                      children: [
                        Text("Total: ",style:const TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                        Text(modelOrden.total.toString(),style:const TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
            const Divider(
              color: Colors.white,
              height: 2.0,
              //thickness: 5,
            ),

            ],
          ),

        ),        
      ),
 
    );
  }


}

class ItemFilaFactura extends StatelessWidget {
  
 final ModelOrdenesDetalle ordeneDetalle;
 final int index;
  
  // ignore: use_key_in_widget_constructors
  const ItemFilaFactura(
    this.index,
    this.ordeneDetalle
  );
  @override
  Widget build(BuildContext context) {
    return Row( 
      children: <Widget>[
        _ItemFactura(index.toString(),0.10,const Color(0xff072734)), 
        _ItemFactura(ordeneDetalle.descripcion,0.45,const Color(0xff072734)), 
        _ItemFactura(ordeneDetalle.cantidad.toString(),0.15,const Color(0xff072734)),
        _ItemFactura(ordeneDetalle.precio.toString(),0.15,const Color(0xff072734)),
        _ItemFactura(ordeneDetalle.total.toString(),0.15,const Color(0xff072734)), 
      ]
    );
  }
}
class _ItemFactura extends StatelessWidget {
  final String texto;
  final double ancho;
  final Color colorItem;
  const _ItemFactura(
    this.texto, 
    this.ancho,
    this.colorItem
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorItem,
      height: 40,
      width: MediaQuery.of(context).size.width * ancho,
      child: Center(child: Text(texto,style:const TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold)))
    );
  }
}


Widget crearMapa(MapaProvider mapaProvider){
  
  LatLng? newCameraPosition;

  const camaraPosition = CameraPosition(
    target: LatLng(-2.897326, -79.004616), //Parque Calderon
    zoom: 15
  );

 return GoogleMap(
      myLocationEnabled: true,
      initialCameraPosition:camaraPosition,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapaProvider.initMapa,
      onCameraMove: (camaraPosition){
        newCameraPosition=camaraPosition.target;
      },
      onCameraIdle: (){
        mapaProvider.ubicacionCentral=newCameraPosition!;
      },
    
    
  );
}