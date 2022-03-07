import 'package:flutter/material.dart';
import 'package:pedidos_appv3/providers/orden_detalle_provider.dart';
import 'package:pedidos_appv3/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class ProductosScreen extends StatelessWidget {
  const ProductosScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    String idEmpresa="";
    String nombre="";
    String imagen="";
    
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // ignore: unnecessary_null_comparison
    if (arguments != null){
      idEmpresa=arguments['id'];
      nombre=arguments['nombre'];
      imagen=arguments['imagen'];
     
    }
    final ordenDetalleProvider = Provider.of<OrdenDetalleProvider>(context);
    int cantidadDetalles = ordenDetalleProvider.cantidadDetalles;
    
    return Scaffold(
      //backgroundColor: Color(0xff211034),
      backgroundColor: const Color(0xff072734),
      floatingActionButton: cantidadDetalles == 0 
        ? Container()
        : const FloatingActionButtonWidget(),
      body: CustomScrollView(
        slivers: [
          _HeaderEmpresa(nombre: nombre,imagen:imagen),
          SliverList(
            delegate: SliverChildListDelegate([
               Container(
                 margin: const EdgeInsets.only(left:10,right:10,bottom: 50),
                 width: double.infinity,
                 height: 800,
                 child: MarketPlaceProductos(idEmpresa:idEmpresa),
               )
            ])
          )
        ],
      ),
    );
  }
}

class _HeaderEmpresa extends StatelessWidget {
  
  final String nombre;
  final String imagen;
  const _HeaderEmpresa({
    Key? key,
    required this.nombre,
    required this.imagen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // ignore: deprecated_member_use
      brightness: Brightness.light,
      //systemOverlayStyle: SystemUiOverlayStyle.light, 
      backgroundColor: Colors.black,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black45,
          child: Text(
            nombre,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(imagen),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}