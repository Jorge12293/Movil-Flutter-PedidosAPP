import 'package:flutter/material.dart';


class AuthBackground extends StatelessWidget {

  final Widget child;

  const AuthBackground({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
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
        child: const Icon(Icons.person_pin,color: Colors.white,size:100),
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
      height: size.height*0.4,
      decoration: _blueBackground(),
      child: Stack(
        children: [
          Positioned(top:90,left:30,child: _Bubble()),
          Positioned(top:-40,left:-30,child: _Bubble()),
          Positioned(top:-50,right:-20,child: _Bubble()),
          Positioned(bottom:-50,left:10,child: _Bubble()),
          Positioned(bottom:120,right:20,child: _Bubble()),
        ],
      ),
    );
  }

  BoxDecoration _blueBackground() => const BoxDecoration(
    gradient: LinearGradient(
      colors:[
        Colors.black,
        Color(0xff072734),
        Colors.black,
        //Colors.black54,
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

