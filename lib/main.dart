import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pedidos_appv3/providers/orden_detalle_provider.dart';
import 'package:pedidos_appv3/screens/check_auth_screen.dart';
import 'package:pedidos_appv3/screens/page_conductores/conductores_page.dart';
import 'package:pedidos_appv3/screens/page_login/page_login.dart';
import 'package:pedidos_appv3/screens/page_mapa/mapa_page.dart';
import 'package:pedidos_appv3/screens/page_reportes/page_reportes.dart';
import 'package:pedidos_appv3/screens/screens.dart';
import 'package:pedidos_appv3/services/auth_services.dart';
import 'package:pedidos_appv3/services/categoria_empresa_services.dart';
import 'package:pedidos_appv3/services/notifications_services.dart';
import 'package:provider/provider.dart';
import 'providers/mapa_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> FacturaService()),
        ChangeNotifierProvider(create: (_)=> ProductsService()),
        ChangeNotifierProvider(create: (_)=> EmpresaService()),
        ChangeNotifierProvider(create: (_)=> OrdenesService()),
        ChangeNotifierProvider(create: (_)=> CategoriaEmpresaService()),
        ChangeNotifierProvider(create: (_)=> AuthService()),
        ChangeNotifierProvider(create: (_)=> OrdenDetalleProvider()),
        ChangeNotifierProvider(create: (_)=> MapaProvider()),
      ],
      child: const MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          // ignore: deprecated_member_use
          backwardsCompatibility: false, // 1
          systemOverlayStyle: SystemUiOverlayStyle.light, // 2
        ),
      ),
      title: "PEDIDOS APP",
      debugShowCheckedModeBanner: false,
      initialRoute: 'loginPage',
      routes: { 
        'login':(_)=> const LoginScreen(),
        'home':(_)=> const HomeScreen(),
        'productos':(_)=> const ProductosScreen(),
        'products':(_)=> const EditProductosScreen(),
        'product':(_)=> const ViewNewProduct(),
        'pedidos':(_)=> const PedidosScreen(),
        'carrito':(_)=>const CarritoScreen(),
        'productoDetalle':(_)=>const ProductoDetalleScreen(),
        'detalleOrdenPage':(_)=>DetalleOrdenPage(),
        'mapaPage':(_)=>const MapaPage(),
        'verOrdenPage':(_)=> const VerOrdenPage(),
        'perfilPage':(_)=> const PagePerfil(),
        'listOrdenPage':(_)=>  ListOrdenPage(),
        'reportesPage':(_)=>  PageReportes(),
        'loginPage':(_)=>  const LoginPage(),
        'conductoresPage':(_)=> ConductoresPage(),
        'checkAuth':(_)=> const CheckAuthScreen(),
      },
      scaffoldMessengerKey:NotificationsServices.messagerKey,

    );
  }
}