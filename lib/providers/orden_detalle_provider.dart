//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pedidos_appv3/models/model_ordenes_detalle.dart';


class OrdenDetalleProvider extends ChangeNotifier {

  int _cantidadDetalles = 0;
  String _idConductor = "";
  String _nombreConductor = "";

  double _totalOrden = 0;
  late ModelOrdenesDetalle _ordenDetalle;
  List<ModelOrdenesDetalle> _listaOrdenDetalles = [];

  int get cantidadDetalles=> _cantidadDetalles;
  set cantidadDetalles(int value){
    _cantidadDetalles = value;
    notifyListeners();
  }

  String get idConductor=> _idConductor;
  set idConductor(String value){
    _idConductor = value;
    notifyListeners();
  }

  String get nombreConductor=> _nombreConductor;
  set nombreConductor(String value){
    _nombreConductor = value;
    notifyListeners();
  }

  double get totalOrden=> _totalOrden;
  set totalOrden(double value){
    _totalOrden = value;
    notifyListeners();
  }
 
  int cantidadProductoDetalle (String idProducto){
    int cantidad=0;
    // ignore: avoid_function_literals_in_foreach_calls
    _listaOrdenDetalles.forEach((element) => {
      if(element.idProducto == idProducto) {
         cantidad=element.cantidad,
      }
    });
    return cantidad;
  }

  List<ModelOrdenesDetalle> get listaOrdenDetalles => _listaOrdenDetalles;

  ModelOrdenesDetalle get ordenDetalle => _ordenDetalle;
  
  set ordenDetalle(ModelOrdenesDetalle ordenDetalle){
     _addOrdenDetalle(ordenDetalle);
     notifyListeners();
  }

  void _addOrdenDetalle(ModelOrdenesDetalle ordenDetalle) {
    bool existe=false;
    // ignore: avoid_function_literals_in_foreach_calls
    _listaOrdenDetalles.forEach((element) => {
      if(element.idProducto == ordenDetalle.idProducto) {
        _cantidadDetalles += 1,
        element.cantidad  += 1,
        element.total=element.cantidad*element.precio,
        existe=true
      }
    });
  
    if(!existe){
      ordenDetalle.cantidad+=1;
      ordenDetalle.total  = ordenDetalle.cantidad*ordenDetalle.precio;
      _ordenDetalle = ordenDetalle;
      _cantidadDetalles += 1;
      _listaOrdenDetalles.add(ordenDetalle);
    }
    updateCantidadDetalles();
  }

  void removeOrdenDetalle(String idProducto) {
    var toRemove = [];
    // ignore: avoid_function_literals_in_foreach_calls
    _listaOrdenDetalles.forEach((element) => {
      if(element.idProducto == idProducto) {
        toRemove.add(element) 
      }
    });
    _listaOrdenDetalles.removeWhere( (e) => toRemove.contains(e));
    updateCantidadDetalles();
    notifyListeners();
  }

  void addItemCantidadDetalle(String idProducto){
    // ignore: avoid_function_literals_in_foreach_calls
    _listaOrdenDetalles.forEach((element) => {
      if(element.idProducto == idProducto) {
        element.cantidad  += 1,
        element.total=element.cantidad*element.precio,
      }
    });
    updateCantidadDetalles();
    notifyListeners();
  }

  void removeItemCantidadDetalle(String idProducto){
    bool eliminarItem = false;
    // ignore: avoid_function_literals_in_foreach_calls
    _listaOrdenDetalles.forEach((element) => {
      if(element.idProducto == idProducto) {
        element.cantidad  -= 1,
        if(element.cantidad==0){
           eliminarItem=true,
        }else{
           element.total=element.cantidad*element.precio,
        }
      }
    });

    if(eliminarItem){
      removeOrdenDetalle(idProducto);
    }

    updateCantidadDetalles();
    notifyListeners();
  }
  
  void updateCantidadDetalles(){
     _totalOrden=0;
     _cantidadDetalles=0;
    // ignore: avoid_function_literals_in_foreach_calls
    _listaOrdenDetalles.forEach((element) => {
      _cantidadDetalles=_cantidadDetalles+element.cantidad,
      _totalOrden=_totalOrden+element.total
    });
  }


  void limpiarCarrito(){
    _cantidadDetalles = 0;
    _totalOrden = 0;
    _ordenDetalle;
    _listaOrdenDetalles = [];
  }

}