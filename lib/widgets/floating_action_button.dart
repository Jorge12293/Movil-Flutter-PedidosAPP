import 'package:flutter/material.dart';
import 'package:pedidos_appv3/providers/orden_detalle_provider.dart';
import 'package:provider/provider.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return  Container(
        height: 80,
        width: 80,
        child:Stack(
          children: const [
            _FloatButtonCar(),
            _FloatButtonCarCount(), 
          ],
        ),
      );
  }
}

class _FloatButtonCarCount extends StatefulWidget {
  const _FloatButtonCarCount({
    Key? key,
  }) : super(key: key);

  @override
  __FloatButtonCarCountState createState() => __FloatButtonCarCountState();
}

class __FloatButtonCarCountState extends State<_FloatButtonCarCount> {
  @override
  Widget build(BuildContext context) {
  final cantidadDetalles = Provider.of<OrdenDetalleProvider>(context).cantidadDetalles;

    return Positioned(
      top: 0,
      right: 10,
      child:Container(
        decoration: const BoxDecoration(
          //color: Color(0xff215593).withOpacity(0.7),
          color: Color(0xff05dc80),
          borderRadius: BorderRadius.all(Radius.circular(100))
        ),
        child:Padding(
          padding: const EdgeInsets.only(top:5,bottom: 5, left: 10,right: 10),
          child: Text(cantidadDetalles.toString(),style: const TextStyle(fontSize: 20,color: Colors.white))
        )
      )
    );
  }
}

class _FloatButtonCar extends StatelessWidget {
  const _FloatButtonCar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right:20,
      child:Container(
        decoration: const BoxDecoration(
          //color: Color(0xff215593).withOpacity(0.7),
          color: Color(0xff215593),
          borderRadius: BorderRadius.all(Radius.circular(100))
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            child: const Icon(Icons.shopping_cart_outlined,color: Color(0xffdd1137),size: 40),
            onTap: (){
              Navigator.pushNamed(context,'carrito');
            },
          )
        )
      )
    );
  }
}