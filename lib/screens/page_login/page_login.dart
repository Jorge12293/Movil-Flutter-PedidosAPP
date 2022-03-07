import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pedidos_appv3/screens/page_login/widgets/liquid_pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String texto='';
  Color? colorTexto=Colors.blue[100];
  @override
  void initState() {
    super.initState();
    texto='REGISTRARSE';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: liquidPages,
        enableLoop: true,
        fullTransitionValue: 880,
        positionSlideIcon: 0.8,
        slideIconWidget: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text( texto, 
                style: TextStyle(color:colorTexto,fontSize: 20,fontWeight: FontWeight.bold)),
            const Icon( Icons.arrow_back_ios, color: Colors.blue, size: 40 ),
          ],
        ),
       waveType: WaveType.liquidReveal,
        onPageChangeCallback: (page)=>pageChangeCallback(page),
        currentUpdateTypeCallback: (updateType)=> updateTypeCallback(updateType),
      ),
    );
  }

  pageChangeCallback(int page){
    if(page==0){
      texto='REGISTRARSE';
      colorTexto=Colors.blue[100];
    }else{
      texto='INGRESAR';
      colorTexto=const Color(0xff072734);
    }
    setState(() {});
  }

  updateTypeCallback(UpdateType updateType){
    print(updateType);
    
  }
}