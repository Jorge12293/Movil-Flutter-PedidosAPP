import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedidos_appv3/models/models.dart';
import 'package:pedidos_appv3/screens/loading_screen.dart';
import 'package:pedidos_appv3/services/services.dart';
import 'package:provider/provider.dart';

class ItemBoton {
  final IconData icon;
  final ModelOrden orden;
  final Color color1;
  final Color color2;
  ItemBoton( this.icon, this.orden, this.color1, this.color2 );
}

class BotonGordo extends StatelessWidget {

  final IconData icon;
  @required final ModelOrden orden;
  final Color color1;
  final Color color2;
  @required final String ordenId;

  // ignore: use_key_in_widget_constructors
  const BotonGordo({
    this.icon = FontAwesomeIcons.circle,
    required this.orden,
    this.color1 = Colors.grey,
    this.color2 = Colors.blueGrey,
    required this.ordenId
  });

  @override
  Widget build(BuildContext context) {
    
    final ordenesService = Provider.of<FacturaService>(context);
    final ordenesDetService = Provider.of<OrdenesService>(context);
    if(ordenesService.isLoading) return const LoadingScreen();
    
    return GestureDetector(
      onTap: ()async{
        await ordenesDetService.getDetalles(orden.id);  
        Navigator.pushNamed(
         context,
         'verOrdenPage',
          arguments:{ 
            'orden': orden,
            'detalles': ordenesDetService.ordenesDetalleList,
          }
        ); 
      },
      child: Stack(
        children: <Widget>[
          _BotonGordoBackground( icon, color1, color2 ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox( height: 140, width: 40 ),
              FaIcon( icon, color: Colors.white, size: 40 ),
              const SizedBox( width: 20 ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( "Fecha: ${orden.fecha}", style: const TextStyle( color: Colors.white, fontSize: 18 ) ),
                    const Text( "Ubicacion: Cuenca", style: TextStyle( color: Colors.white, fontSize: 18 ) ),
                    Text( "Total: ${orden.total} ", style: const TextStyle( color: Colors.white, fontSize: 18 ) ),
                    Text( "Estado: ${orden.estado}", style: const TextStyle( color: Colors.white, fontSize: 18 ) ),
                  ],
                )
              ),
              const FaIcon( FontAwesomeIcons.chevronRight, color: Colors.white ),
              const SizedBox( width: 40 ),
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
      height: 100,
      margin: const EdgeInsets.all( 20 ),
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