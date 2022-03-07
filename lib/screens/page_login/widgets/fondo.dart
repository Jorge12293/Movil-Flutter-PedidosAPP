import 'package:flutter/material.dart';

class FondoLogin extends StatelessWidget {

  final Color primario;
  final Color secundario;
  final Widget child;
  
  const FondoLogin({
    required this.primario,
    required this.secundario,
    required this.child,
    Key? key, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  BoxDecoration _blueBackground() =>  BoxDecoration(
    gradient: LinearGradient(
      colors:[
        secundario,
        primario,
        secundario
      ] 
    )
  );
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(decoration: _blueBackground()),
          _BlueBox(),
          _HeaderIcon(),
          child
        ],
      ),
   );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top:30),
        child: Column(
          children:[
            Text("PedidosApp", 
              style: TextStyle(
              color: Colors.blueGrey.shade100,fontSize: 30
            )),
            const Icon(Icons.person_pin,color: Colors.white,size:100),
          ],
        )
      ),
    );
  }
}

class _BlueBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
     // decoration: _blueBackground(),
      child: Stack(
        children: [
          Positioned(top:90,left:30,child: _Bubble()),
          Positioned(top:120,right:20,child: _Bubble()),
          Positioned(top:450,left:10,child: _Bubble()),
          Positioned(top:500,right:20,child: _Bubble()),
          Positioned(top:600,left:20,child: _Bubble()),
          Positioned(top:650,right:10,child: _Bubble()),
        ],
      ),
    );
  }

  BoxDecoration _blueBackground() => const BoxDecoration(
    gradient: LinearGradient(
      colors:[
        /*Colors.black,
        Color(0xff072734),
        Colors.black,
        */
     
        Color(0xff072734),
        Colors.black,
        Color(0xff072734),
      ] 
    )
  );
}

class _Bubble extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: 100,
      height: 100,
      child: const Icon(Icons.shopping_cart_outlined,color: Colors.white38,size:70),
    );
  }
}

