import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedidos_appv3/screens/page_reportes/page_reportes.dart';
import 'package:pedidos_appv3/screens/screens.dart';



final pageRoutes = <_Route>[
  _Route(FontAwesomeIcons.home, 'INICIO', const HomeScreen()),
  _Route(Icons.person, 'PERFIL', const PagePerfil()),
  _Route(FontAwesomeIcons.shoppingCart, 'CARRITO', const CarritoScreen()),
  _Route(FontAwesomeIcons.fileAlt, 'ORDENES', ListOrdenPage()),
  _Route(Icons.data_usage, 'REPORTES', PageReportes()),
  
   
];

class _Route{

  final IconData icon;
  final String titulo;
  final Widget page;

  _Route(this.icon, this.titulo, this.page);


}