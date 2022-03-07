import 'package:flutter/material.dart';
import 'package:pedidos_appv3/providers/login_form_provider.dart';
import 'package:pedidos_appv3/screens/page_login/widgets/fondo.dart';
import 'package:pedidos_appv3/services/auth_services.dart';
import 'package:pedidos_appv3/services/notifications_services.dart';
import 'package:pedidos_appv3/ui/input_decorations.dart';
import 'package:pedidos_appv3/widgets/card_container.dart';
import 'package:provider/provider.dart';

class Registrar extends StatelessWidget {
  const Registrar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FondoLogin(
      /*
      primario: const Color(0xff161621),
      secundario: const Color(0xff161621),
      */
      primario:const Color(0xff02d39a).withOpacity(0.7),
      secundario:const Color(0xff02d39a).withOpacity(0.7),
      child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 200),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ChangeNotifierProvider(
                      create: (_)=>LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                )
              )],
          ),
        ),

    );
  }
}



class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key:loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const Text("REGISTRAR", style: TextStyle(color: Color(0xff072734),fontSize: 23,fontWeight: FontWeight.bold)),
          TextFormField(
            autocorrect: false,
            keyboardType:TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'ejmplo@hotmail.com',
              labelText: 'Email',
              prefixIcon: Icons.alternate_email_rounded,
            ),
            onChanged: (value) => loginForm.email=value,
            validator: (value){
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'; 
              RegExp regExp  =  RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                     ? null
                     :'Correo no Valido';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType:TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              hintText: '******',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline
            ),
            onChanged: (value) => loginForm.password=value,
            validator: (value){
              return (value != null && value.length>=6)
                ? null
                : 'La contraseña debe ser de 6 Caracteres';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            disabledColor: const Color(0xff525252),
            elevation: 0,
            color: const Color(0xff072734),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 15),
              child: Text(
                   loginForm.isLoading
                   ?'Espere....'
                   :'Registrar',
                   style: const TextStyle(color: Colors.white))
            ),
            onPressed:loginForm.isLoading ? null :() async{
              
              FocusScope.of(context).unfocus();
              final authService = Provider.of<AuthService>(context,listen: false);

              if(!loginForm.isValidForm()) return;
            
              loginForm.isLoading=true;
              final String? errorMessage = await authService.createUser(loginForm.email, loginForm.password);
              
              if(errorMessage == null){
                Navigator.pushReplacementNamed(context, 'home');
              }else{
                NotificationsServices.showSnackbar(errorMessage,'error');
                loginForm.isLoading=false;
              }
              
            }
          )
        ],
      ),
    );
  }
}