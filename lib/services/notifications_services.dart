import 'package:flutter/material.dart';

class NotificationsServices{

  static GlobalKey<ScaffoldMessengerState> messagerKey = GlobalKey<ScaffoldMessengerState>();
  
  static showSnackbar(String message, String tipo){

    Color colorTipo = Colors.black;

    if(tipo=='error'){
      colorTipo=Colors.redAccent;
    }
    if(tipo=='info'){
      colorTipo=Colors.blueAccent;
    }

    if(message=='INVALID_PASSWORD'){
      message='PASSWORD INCORRECTO';
    }

    if(message=='EMAIL_NOT_FOUND'){
      message='CORREO NO REGISTRADO';
    }

    final snackBar = SnackBar(
      backgroundColor: colorTipo,
      content: Text(message, style: const TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold))
    );

    messagerKey.currentState!.showSnackBar(snackBar);
  }

  
}