import 'package:flutter/material.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //appBar: AppBar(
        //title: Text("Products"),
      //),
      //backgroundColor: Color(0xff211034),
      backgroundColor:Color(0xff072734),
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
     ),
   );
  }
}