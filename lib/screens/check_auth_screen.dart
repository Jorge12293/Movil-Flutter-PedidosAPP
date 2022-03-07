import 'package:flutter/material.dart';
import 'package:pedidos_appv3/screens/home_screen.dart';
import 'package:pedidos_appv3/screens/page_login/page_login.dart';
import 'package:pedidos_appv3/services/auth_services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen:false);

    return Scaffold(
      body: Center(
        child:FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            
            if(!snapshot.hasData){
              return const Text('Espere...');
            }

            if(snapshot.data == ''){
              Future.microtask(() => {
                Navigator.pushReplacement(context,PageRouteBuilder(
                    pageBuilder:  ( _ , __ , ___ ) => const LoginPage(),
                    transitionDuration: const Duration(seconds: 6)
                  )
                )
              });
            }else{
              Future.microtask(() => {
                Navigator.pushReplacement(context,PageRouteBuilder(
                    pageBuilder:  ( _ , __ , ___ ) => const HomeScreen(),
                    transitionDuration: const Duration(seconds: 6)
                  )
                )
              });
            }
            
            return Container(
              color: const Color(0xff02d39a).withOpacity(0.7),
              child: const Center(
                child: Text("Looading....", style: TextStyle(color: Color(0xff072734),fontSize: 30,fontWeight: FontWeight.bold)),
            ),
            );
          },
        )
      ),
    );
  }
}