import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedidos_appv3/helpers/helpers.dart';
import 'package:pedidos_appv3/providers/orden_detalle_provider.dart';
import 'package:pedidos_appv3/routes.dart/routes.dart';
import 'package:pedidos_appv3/services/auth_services.dart';
//import 'package:pedidos_appv3/services/notifications_services.dart';
import 'package:pedidos_appv3/widgets/categoria_empresa.dart';
import 'package:pedidos_appv3/widgets/floating_action_button.dart';
import 'package:pedidos_appv3/widgets/widgets.dart';
import 'package:provider/provider.dart';
//import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
//import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

// int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    cambiarStatusLight();
    final ordenDetalleProvider = Provider.of<OrdenDetalleProvider>(context);
    int cantidadDetalles = ordenDetalleProvider.cantidadDetalles;

    /*
    WidgetsBinding.instance?.addPostFrameCallback((_){
      NotificationsServices.showSnackbar('Bienvenido Jorge','info');
    });
    */

    return Scaffold(
      backgroundColor: const Color(0xff072734),
      appBar: AppBar(
        title: const Text('PedidosApp'),
        //backgroundColor: Color(0xff215593)
        backgroundColor: Colors.black,   
        
      ),
      floatingActionButton: cantidadDetalles== 0 
        ? Container()
        : const FloatingActionButtonWidget(),
      drawer: _MenuPrincipal(),
      /*
      bottomNavigationBar: SalomonBottomBar(
        duration: Duration(seconds: 1),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor:Colors.white,
        margin: const EdgeInsets.only(
          bottom: 30,
          top:10,
          right:20,
          left: 20
        ),
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
        items: [
         SalomonBottomBarItem(
           icon: const Icon(Icons.home),
           title: const Text('HOME'),
           selectedColor: Colors.white
         ),
         SalomonBottomBarItem(
           icon: const Icon(Icons.shopping_cart_outlined),
           title: const Text('CARRITO'),
           selectedColor: Colors.redAccent
         ),
         SalomonBottomBarItem(
           icon: const Icon(Icons.data_usage),
           title: const Text('REPORTES'),
           selectedColor: Colors.orange
         ),
         SalomonBottomBarItem(
           icon: const Icon(Icons.settings),
           title: const Text('PERFIL'),
           selectedColor: Colors.teal
         ),
          
        ],
      ),
      */
      body: Column(
        children: const [ 
          CategoriaEmpresa(),
          Expanded(child: MarketPlace()),
        ],
      )
   );
  }
}


class _ListaOpciones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context,i)=>const Divider(
        color: Colors.blue,
      ),
      itemCount: pageRoutes.length,
      itemBuilder: (context,i)=>ListTile(
        leading: FaIcon(pageRoutes[i].icon, color: Colors.blue),
        title: Text(pageRoutes[i].titulo,style:const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.chevron_right, color: Colors.blue),
        onTap: (){
           Navigator.push(context, MaterialPageRoute(builder:(context) => pageRoutes[i].page));
        },
      ),
    );
  }
}


class _MenuPrincipal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context,listen:false);
    return Drawer(
      child: Container(
       // color: Colors.black,
        color:const Color(0xff072734),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 150,
              child: const CircleAvatar(
                backgroundColor: Colors.blue,
                child:Icon(
                  Icons.person_sharp,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            const Text("Jorge Rivera", style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold)),
            Expanded(child: _ListaOpciones()),
            SafeArea(
              bottom: true,
              top: false,
              left: false,
              right: false,
              child:Container(
                decoration: const BoxDecoration(

                  //color:Color(0xff072734),
                  //color: Color(0xff211034),
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(25),
                    topRight:Radius.circular(25),
                  )
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                       top:20,
                       bottom:20,
                       left:20,
                       right:20
                      ),
                      child: GestureDetector(
                        child: Container(
                          height: 40,
                          width: double.infinity, 
                          decoration: const BoxDecoration(
                            color: Color(0xffff4200),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20)
                            )
                          ),
                          child:const Center(child: Text("SALIR",style: TextStyle(color: Colors.white,fontSize: 20))),
                        ),
                        onTap: (){
                          authService.logout();
                          Navigator.pushReplacementNamed(context,'loginPage');
                        },
                      ),
                    ),
                  ],
                )
              )
            )
          ],
        ),
      ),
    );
  }
}





