import 'package:flutter/material.dart';
import 'package:pedidos_appv3/providers/login_form_provider.dart';
import 'package:pedidos_appv3/ui/input_decorations.dart';
import 'package:pedidos_appv3/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff072734),
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 200),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('LOGIN',style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_)=>LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                )
              ),
              const SizedBox(height: 50),
              const Text('Crear Una nueva Cuenta',style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 50),
            ],
          ),
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
            color: const Color(0xff05dc80),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 15),
              child: Text(
                   loginForm.isLoading
                   ?'Espere....'
                   :'Ingresar',
                   style: const TextStyle(color: Colors.white))
            ),
            onPressed:loginForm.isLoading ? null :() async{
              
              FocusScope.of(context).unfocus();

              if(!loginForm.isValidForm()) return;
            
              loginForm.isLoading=true;
              

              await Future.delayed(const Duration(seconds: 5));
              loginForm.isLoading=false;
              Navigator.pushReplacementNamed(context, 'home');
            }
          )
        ],
      ),
    );
  }
}