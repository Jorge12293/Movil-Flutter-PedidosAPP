import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pedidos_appv3/models/model_ordenes_detalle.dart';
//import 'package:pedidos_appv3/models/models.dart';
import 'package:pedidos_appv3/providers/orden_detalle_provider.dart';
import 'package:provider/provider.dart';


class CarritoScreen extends StatefulWidget {
  const CarritoScreen({Key? key}) : super(key: key);
  @override
  _CarritoScreenState createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  @override
  Widget build(BuildContext context) {

    final ordenDetalleProvider = Provider.of<OrdenDetalleProvider>(context);

   List<ModelOrdenesDetalle> _listOrdenDetalles = ordenDetalleProvider.listaOrdenDetalles;
// child: Icon(Icons.shopping_cart_outlined,color: Color(0xffdd1137),size: 40),
    return Scaffold(
     // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Carrito'),
            Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 35),
          ],
        ),
        //title: Text('Carrito'),
        backgroundColor: Colors.black
      ),
      body:Container(
        color:const Color(0xff072734),
       // color: Color(0xff606060),
        child: Column(
          children: [
            Container(
              color:const Color(0xff072734),
              child: Row(
                children: const <Widget>[
                  _CabeceraFacturaTitle("PRODUCTO",0.25), 
                  _CabeceraFacturaTitle("DESCRIPCION",0.50),
                  _CabeceraFacturaTitle("TOTAL",0.25), 
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
                itemCount: _listOrdenDetalles.length,
                itemBuilder: (context, int index)=>_CarritoItem(_listOrdenDetalles[index],ordenDetalleProvider)
              ),
            ),
            _FooterFactura(ordenDetalleProvider: ordenDetalleProvider)
          ],
        ),
      )
    
   );
  }
}

class _FooterFactura extends StatelessWidget {
  const _FooterFactura({
    Key? key,
    required this.ordenDetalleProvider,
  }) : super(key: key);

  final OrdenDetalleProvider ordenDetalleProvider;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      left: false,
      right: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(20),
            topRight:Radius.circular(20),
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
               top:10,
               bottom:10,
               left:20,
               right:20
              ),
              child: Container(
                height: 40,
                width: double.infinity,
                color: Colors.white,
                child: Center(child: Text("TOTAL = ${ordenDetalleProvider.totalOrden} \$",style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold))),
              ),
            ),
            SizedBox(
              width: 350,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  backgroundColor: const Color(0xff05dc80),
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
                ),
                child: const Text("GRABAR ORDEN",style: TextStyle(color: Colors.white,fontSize: 20)),
                onPressed: (){
                  Navigator.pushNamed(context,'detalleOrdenPage');
                },
              ),
            ),

          ],
        ),
      )
    );
  }
}

class _CabeceraFacturaTitle extends StatelessWidget {
  
  final String texto;
  final double ancho;
  const _CabeceraFacturaTitle(
    this.texto, 
    this.ancho,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff545454),
      height: 40,
      width: MediaQuery.of(context).size.width * ancho,
      child: Center(child: Text(texto,style:const TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold)))
    );
  }
}

class _CarritoItem extends StatelessWidget {
  final ModelOrdenesDetalle _ordenDetalle;
  final OrdenDetalleProvider _ordenDetalleProvider;
  const _CarritoItem(
    this._ordenDetalle,
    this._ordenDetalleProvider
  );

  @override
  Widget build(BuildContext context) {

    return Dismissible(
      key: Key(_ordenDetalle.idProducto),
      direction: DismissDirection.startToEnd,
      onDismissed: (direcction){
        _ordenDetalleProvider.removeOrdenDetalle(_ordenDetalle.idProducto);
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: const Color(0xffce5a5a),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children:[
              BounceInDown(
                from: 10,
                child: const Icon(Icons.delete, color: Colors.black,size: 50)
              ),
              BounceInDown(
                from: 10,
                child: const Text("DELETE",style:TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold))
              ),
              
            ],
          )  
        ),
      ),
      child: Container(
        color:const Color(0xff072734),
        child: Row(
          children: <Widget>[
            // ignore: sized_box_for_whitespace
            Container(
              //color: Colors.white,
              height: 105,
              width: MediaQuery.of(context).size.width * 0.25,
              child:Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    width:  70,
                    height: 70,
                    placeholder: const AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(_ordenDetalle.imagen),
                    fit:BoxFit.fill
                  ),
                ),
              ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: 105,
              width: MediaQuery.of(context).size.width * 0.50,
              child: Column(
                children: [
                  Center(child: Text(_ordenDetalle.descripcion.toString(),style:const TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold))),
                  Text("PU: ${_ordenDetalle.precio} \$",style: const TextStyle(color: Colors.white)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent,width: 2.0),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(25.0) //                 <--- border radius here
                            ),
                          ),
                          child: Stack(
                              children: [
                                  Center(
                                   child: Text(_ordenDetalle.cantidad.toString(),style:const TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold))
                                  ),
                                  Positioned(
                                     top: -20,
                                     left:5,
                                     child: GestureDetector(
                                        onTap: (){
                                          _ordenDetalleProvider.removeItemCantidadDetalle(_ordenDetalle.idProducto);
                                        },
                                        child: const Icon(Icons.arrow_left_sharp,color: Color(0xff05dc80),size: 85)
                                    ),
                                   ),
                                   Positioned(
                                     top: -20,
                                     right:5,
                                     child: GestureDetector(
                                        onTap: (){
                                          _ordenDetalleProvider.addItemCantidadDetalle(_ordenDetalle.idProducto);
                                        },
                                        child: const Icon(Icons.arrow_right_sharp,color: Color(0xff05dc80),size: 85)
                                    ),
                                   ),
                                  
                              ],
              
                          ),
                       ),
                     ) 
                    ],
                  ),
                  
                ],
              ),
            ),
          
            // ignore: sized_box_for_whitespace
            Container(
              height: 105,
              width: MediaQuery.of(context).size.width * 0.25,
              child: Center(child: Text("${_ordenDetalle.total}\$",style:const TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),
            ),
            
          ]
        )
      )

    );
  }
}

