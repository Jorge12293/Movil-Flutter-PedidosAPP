
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedidos_appv3/providers/mapa_provider.dart';
import 'package:provider/provider.dart';


class MapaPage extends StatelessWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final width = MediaQuery.of(context).size.width;
    final mapaProvider = Provider.of<MapaProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          crearMapa(mapaProvider),
          Center(
            child: Transform.translate(
              offset: const Offset(0,12),
              child: BounceInDown(
                from: 200,
                child: const Icon(Icons.location_on,size: 50, color: Colors.red)
              ),
            )        
          ),

          Positioned(
            top:70,
            left:20,
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back,size: 30), 
                onPressed: (){
                  Navigator.of(context).pop();
                }
              ),
            )
          ),


          Positioned(
            bottom: 70,
            left: 65,
            child: MaterialButton(
               minWidth: width-120,
              child: const Text('Confirmar Destino', style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: const StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: (){
                //print(mapaProvider.direccionEnvio);
                 Navigator.of(context).pop();
              },
            )
          )
        ],
      )
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
