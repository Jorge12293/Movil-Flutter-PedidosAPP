import 'package:flutter/material.dart';

class PagePerfil extends StatefulWidget {
  const PagePerfil({Key? key}) : super(key: key);

  @override
  State<PagePerfil> createState() => _PagePerfilState();
}

class _PagePerfilState extends State<PagePerfil> {

  String _nombre ='Jorge';
  String _apellido ='Rivera';
  final String _telefono ='0981056705';
  String _email = 'jorge@gmail.com';
  String _password = '1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PERFIL'),
        backgroundColor: Colors.black
      ),
      backgroundColor: Colors.white,
      body:ListView(
        padding:const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          const SizedBox(
          width: double.infinity,
          height: 80,
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            child:Icon(
              Icons.person_sharp,
              color: Colors.white,
              size: 50,
            ),
            ),
          ),

          ExpansionTile(
            title: Row(
              children: [
                const Icon(Icons.account_circle,color: Colors.blueAccent),
                const SizedBox(width: 10), 
                Text('Nombre: $_nombre', 
                    style:const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                   ))
              ],
            ), 
            controlAffinity: ListTileControlAffinity.trailing,
            children: <Widget>[
              const SizedBox(height: 5),
              _inputNombre(),
              const SizedBox(height: 2),
            ],
          ),
          const Divider(),
          ExpansionTile(
            title: Row(
              children: [
                const Icon(Icons.account_circle,color: Colors.blueAccent),
                const SizedBox(width: 10), 
                Text('Apellido: $_apellido', 
                    style:const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                   ))
              ],
            ), 
            controlAffinity: ListTileControlAffinity.trailing,
            children: <Widget>[
              const SizedBox(height: 5),
              _inputApellido(),
              const SizedBox(height: 2),
            ],
          ),
          const Divider(),
          ExpansionTile(
            title: Row(
              children: [
                const Icon(Icons.phone_android_outlined,color: Colors.blueAccent),
                const SizedBox(width: 10), 
                Text('Telefono: $_telefono', 
                    style:const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                   ))
              ],
            ), 
            controlAffinity: ListTileControlAffinity.trailing,
            children: <Widget>[
              const SizedBox(height: 5),
              _inputTelefono(),
              const SizedBox(height: 2),
            ],
          ),
          const Divider(),
          ExpansionTile(
            title: Row(
              children: [
                const Icon(Icons.email,color: Colors.blueAccent),
                const SizedBox(width: 10), 
                Text('Email: $_email', 
                    style:const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                   ))
              ],
            ), 
            controlAffinity: ListTileControlAffinity.trailing,
            children: <Widget>[
              const SizedBox(height: 5),
              _inputEmail(),
              const SizedBox(height: 2),
            ],
          ),
          const Divider(),
          ExpansionTile(
            title: Row(
              children: const [
                 Icon(Icons.lock,color: Colors.blueAccent),
                 SizedBox(width: 10), 
                 Text('Password: ******', 
                    style:TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                   ))
              ],
            ),
            controlAffinity: ListTileControlAffinity.trailing,
            children: <Widget>[
              const SizedBox(height: 5),
              _inputPassword(),
              const SizedBox(height: 2),
            ],
          ),          
          const Divider(),
          MaterialButton(
            elevation: 0,
            onPressed: (){},
            color: const Color(0xff02d39a).withOpacity(0.7),
            padding:const EdgeInsets.symmetric(horizontal: 30,vertical:15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Text("Actualizar", 
                   style:TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                   ))
          )

        ],
      ),
    );
  }

  Widget _inputNombre() {
    return TextFormField(
      //autofocus: true,
      initialValue: _nombre,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Nombre del Usuario',
        labelText: 'Nombre',
        suffixIcon:const Icon(Icons.account_circle),
      ),
        onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _inputApellido() {
    return TextFormField(
      //autofocus: true,
      initialValue: _apellido,
      readOnly: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Apellido del Usuario',
        labelText: 'Apellido',
        suffixIcon:const Icon(Icons.account_circle)),
        onChanged: (valor) {
        setState(() {
          _apellido = valor;
        });
      },
    );
  }

  Widget _inputTelefono() {
    return TextFormField(
      //autofocus: true,
      initialValue: _telefono,
      readOnly: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Telefono del Usuario',
        labelText: 'Telefono',
        suffixIcon:const Icon(Icons.phone),
        ),
        onChanged: (valor) {
        setState(() {
          _apellido = valor;
        });
      },
    );
  }

    Widget _inputEmail() {
    return TextFormField(
      //autofocus: true,
      initialValue: _email,
      readOnly: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Email',
          labelText: 'Email',
          suffixIcon: Icon(Icons.alternate_email)),
      onChanged: (valor) {
        setState(() {
          _email = valor;
        });
      },
    );
  }

  Widget _inputPassword() {
    return TextFormField(
      //autofocus: true,
      initialValue: _password,
      readOnly: false,
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Password',
          labelText: 'Password',
          suffixIcon: Icon(Icons.lock_open)),
      onChanged: (valor) {
        setState(() {
          _password = valor;
        });
      },
    );
  }
}

