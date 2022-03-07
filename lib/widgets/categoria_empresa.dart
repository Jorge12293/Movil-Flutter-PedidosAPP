import 'package:flutter/material.dart';
import 'package:pedidos_appv3/models/model_categoria_empresa.dart';
import 'package:pedidos_appv3/screens/loading_screen.dart';
import 'package:pedidos_appv3/services/categoria_empresa_services.dart';
import 'package:pedidos_appv3/services/empresa_services.dart';

import 'package:provider/provider.dart';

class CategoriaEmpresa  extends StatelessWidget {
  const CategoriaEmpresa ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final empresaServices = Provider.of<EmpresaService>(context);
    final empresaCategoriaServices = Provider.of<CategoriaEmpresaService>(context);
    
    if(empresaCategoriaServices.isLoading) return  Container();
  
     
    return Row(
            children: [
              (empresaServices.filtroCategoria)
                ? const _EliminarFiltroCategoria() 
                : Container(),
              SizedBox(
                height: 100.0,
                width: (empresaServices.filtroCategoria)
                        ? MediaQuery.of(context).size.width*0.78
                        : MediaQuery.of(context).size.width,
               // width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: empresaCategoriaServices.categoriaEmpresasList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index) =>_ItemCategoria(
                    empresaCategoria:empresaCategoriaServices.categoriaEmpresasList[index]
                  )
                ),
              ),
            ],
          );
  }
}



class _EliminarFiltroCategoria extends StatelessWidget {
  const _EliminarFiltroCategoria({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final empresaServices = Provider.of<EmpresaService>(context);
    return Container(
      margin:const EdgeInsets.symmetric(horizontal:10,vertical:10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          backgroundColor: Colors.redAccent,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
        ),
        child:  const Icon(Icons.highlight_remove_sharp,   color: Colors.white,size: 35),
        onPressed: (){
          empresaServices.eliminarFiltro();
        },
      ),
    );
  }
}

class _ItemCategoria extends StatelessWidget {
  
  final ModelCategoriaEmpresa empresaCategoria;

  const _ItemCategoria({
    required this.empresaCategoria
  });

  @override
  Widget build(BuildContext context) {
    final empresaServices = Provider.of<EmpresaService>(context);
    return Container(
      margin:const EdgeInsets.symmetric(horizontal:5,vertical:10),
      child: SizedBox(
        width: 130,
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black,
            backgroundColor: (empresaServices.idSelectCategoria==empresaCategoria.id)
            ?Colors.orangeAccent
            :const Color(0xff05dc80),
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
          ),
          child: Text(empresaCategoria.descripcion,overflow: TextOverflow.ellipsis),
          onPressed: (){
            empresaServices.filtrarCategoria(empresaCategoria.id);
          },
        ),
      ),
    );
  }
}
