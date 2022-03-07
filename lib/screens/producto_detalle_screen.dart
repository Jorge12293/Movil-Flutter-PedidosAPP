import 'package:flutter/material.dart';


class ProductoDetalleScreen extends StatelessWidget {
  const ProductoDetalleScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('DETELLE DEL PRODUCTO'),
        backgroundColor: const Color(0xff215593)
      ),
      // ignore: sized_box_for_whitespace
      body:Container(
          width: double.infinity, 
          height: 200,
          child: const FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: AssetImage('assets/laptop.jpg'),
            //image: NetworkImage(producto.imagen),
            fit:BoxFit.fill
          ),
        )
   );
  }
}