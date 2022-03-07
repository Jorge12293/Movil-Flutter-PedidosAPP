import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pedidos_appv3/models/model_ordenes_detalle.dart';
import 'package:pedidos_appv3/models/models.dart';
import 'package:pedidos_appv3/providers/orden_detalle_provider.dart';
import 'package:pedidos_appv3/screens/loading_screen.dart';
import 'package:pedidos_appv3/services/services.dart';
import 'package:provider/provider.dart';

class MarketPlaceProductos extends StatelessWidget {

  final String idEmpresa;

  // ignore: use_key_in_widget_constructors
  const MarketPlaceProductos({required this.idEmpresa});

  @override
  Widget build(BuildContext context) {
    
      return ChangeNotifierProvider(
          create: (_)=> ProductoService(idEmpresa),
          child: _MenuGrid(),
          
      );
  }
}

class _MenuGrid extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
    final productoServices = Provider.of<ProductoService>(context);
    if(productoServices.isLoading) return const LoadingScreen();

    return  StaggeredGridView.countBuilder(
      padding: const EdgeInsets.only(bottom: 10.0,top: 10.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      itemCount: productoServices.productos.length,
      itemBuilder: (BuildContext context, int index){
        return _MenuGrdidItem(
            index: index,
            producto: productoServices.productos[index]
        );
      },
      staggeredTileBuilder: (int index) =>
        const StaggeredTile.fit(1),
      mainAxisSpacing: 10,
      crossAxisSpacing: 20,
    );
  }
}

class _MenuGrdidItem extends StatelessWidget {

  
  final ModelProducto producto;
  final int index; 
  const _MenuGrdidItem({required this.index,required this.producto});

  @override
  Widget build(BuildContext context) {
  
    return Container(
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
           Stack(
             children: [
               _ProductCard(index: index, producto: producto),
               _AddProductCard(producto: producto),
               _CantProductCard(producto: producto)
             ],
            ),    
          Container(
            height: 40,
            width: double.infinity, 
            decoration: const BoxDecoration(
              color: Color(0xff545454),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
            ),
            child: Center(
              child: Column(
                children: [
                  Text(producto.nombre, style: const TextStyle(color: Colors.white)),
                  Text("\$ ${producto.precio}", style: const TextStyle(color: Colors.white)),
                ],
              )
            )
          )
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    Key? key,
    required this.index,
    required this.producto,
  }) : super(key: key);

  final int index;
  final ModelProducto producto;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
       borderRadius: const BorderRadius.only(
         topRight: Radius.circular(15),
         topLeft: Radius.circular(20),
       ),
       // ignore: sized_box_for_whitespace
       child: Container(
         width: double.infinity, 
         height: index.isEven ? 150 : 150,
         child: FadeInImage(
           //placeholder: AssetImage('assets/jar-loading.gif'),
           placeholder: const AssetImage('assets/no-image.png'),
           image: NetworkImage(producto.imagen),
           fit:BoxFit.fill
         ),
       ),
              );
  }
}

class _AddProductCard extends StatelessWidget {
  
  const _AddProductCard({
    Key? key,
    required this.producto,
  }) : super(key: key);

  final ModelProducto producto;

  @override
  Widget build(BuildContext context) {
  
  final ordenDetalleProvider = Provider.of<OrdenDetalleProvider>(context);

    return Positioned(
      top: 2,
      left:2,
      child:GestureDetector(
        onTap: (){
            String imagen=producto.imagen;
            int    cantidad=0;
            String descripcion=producto.nombre;
            //String idOrden="0";
            String idProducto=producto.id;
            double precio=producto.precio;
            double total=0;
            ModelOrdenesDetalle ordenDetalle = ModelOrdenesDetalle(
      
              cantidad,
              descripcion,
              //idOrden:idOrden,
              idProducto,
              imagen,
              precio,
              total
            );
            ordenDetalleProvider.ordenDetalle=ordenDetalle;
        },
        child: Container(
          decoration: const BoxDecoration(
            //color: Color(0xff215593).withOpacity(0.7),
            color: Color(0xff2f8a9e),
            borderRadius: BorderRadius.all(Radius.circular(100))
          ),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.add_box,color: Color(0xff05dc80),size: 30)
            //child: Icon(Icons.add_box,color:Color(0xff2f8a9e),size: 30)
          )
        ),
      )
    );
  }
  
}


class _CantProductCard extends StatefulWidget {

  const _CantProductCard({
    Key? key,
    required this.producto,
  }) : super(key: key);
  
  final ModelProducto producto;

  @override
  __CantProductCardState createState() => __CantProductCardState();
}

class __CantProductCardState extends State<_CantProductCard> {
  @override
  Widget build(BuildContext context) {
  final ordenDetalleProvider = Provider.of<OrdenDetalleProvider>(context);
  int cantidad = ordenDetalleProvider.cantidadProductoDetalle(widget.producto.id);

    return Positioned(
      top: 2,
      right:2,
      child:cantidad == 0 
        ? Container() 
        : Container(
              decoration: BoxDecoration(
                color: const Color(0xff215593).withOpacity(0.7),
                borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(cantidad.toString(),style: const TextStyle(color:Colors.white,fontFamily: 'Raleway',fontSize: 20)),
                //child: Icon(Icons.add_box,color:Colors.redAccent,size: 30)
              )
          ),
    );
  }
}