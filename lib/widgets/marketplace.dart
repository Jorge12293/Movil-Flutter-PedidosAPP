import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pedidos_appv3/models/models.dart';
import 'package:pedidos_appv3/screens/loading_screen.dart';
import 'package:pedidos_appv3/services/services.dart';
import 'package:provider/provider.dart';

class MarketPlace extends StatelessWidget {
  const MarketPlace({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _MenuGrid();
  }
}


class _MenuGrid extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final empresaServices = Provider.of<EmpresaService>(context);
    if(empresaServices.isLoading) return const LoadingScreen();

    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: empresaServices.empresas.length,
      itemBuilder: (BuildContext context, int index){
        
        return GestureDetector( 
          onTap: (){
            Navigator.pushNamed(
              context,
              'productos',
              arguments:{ 
                 'id': empresaServices.empresas[index].id,
                'nombre': empresaServices.empresas[index].nombre,
                'imagen': empresaServices.empresas[index].imagen
              }
            );
          },
          child: _MenuGridItem(
            index: index,
            empresa: empresaServices.empresas[index],
          ),
        );
      },
      staggeredTileBuilder: (int index) =>
        const StaggeredTile.fit(1),
      mainAxisSpacing: 10,
      crossAxisSpacing: 20,
    );
  }
}

class _MenuGridItem extends StatelessWidget {

  final ModelEmpresa empresa;
  final int index; 
  const _MenuGridItem({required this.index,required this.empresa});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(6),
      child: Column(
        children:<Widget>[
          Container(
            height: 25,
            width: double.infinity, 
            decoration:  BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )
            ),
            child:Center(child: Text(empresa.nombre,style:const TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold))),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: SizedBox(
              width: double.infinity, 
              height: index.isEven ? 125 : 175,
              child: FadeInImage(
               // placeholder: const AssetImage('assets/jar-loading.gif'),
                placeholder: const AssetImage('assets/no-image.png'),
                image: NetworkImage(empresa.imagen),
                fit:BoxFit.fill
              ),
            ),
          ),
        ],
      )
    );
  }
}



