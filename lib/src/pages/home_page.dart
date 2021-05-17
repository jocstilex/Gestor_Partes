import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
//import 'package:gestor_partes/src/pages/pages_generarParte/parte1_pages_generarPartes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _nombre;
  String _passw;
  int code;
  List<String> _roles = ['Tutor', 'Profesor', 'Jefatura', 'Admin', 'Pruebas'];
  String _optSelec = 'Profesor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestor de partes_pagPrin'),
        centerTitle: true,
        backgroundColor: Colors.blue[500],
        //backgroundColor: Colors.pink,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: ListView(
          physics:
              const NeverScrollableScrollPhysics(), //No deja hacer scroll al usuario
          children: [
            Column(
              children: [
                _imgCentro(),
                Divider(),
                _inputName(),
                Divider(),
                _inputPassw(),
                /* _crearDropDown(),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text('Nombre: $_nombre \nContraseña: $code'),
                ) ,*/

                Container(
                    margin: EdgeInsets.only(top: 300),
                    child: _buttonNext(_optSelec)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputName() {
    return TextField(
      textCapitalization: TextCapitalization.words,
      //autofocus: true,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          /*cambiar color del border si esata focus
           focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.yellow, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),

          ), */
          hintText: 'Nombre del/la docente',
          icon: Icon(Icons.account_circle_outlined),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onChanged: (valor) {
        setState(() => _nombre = valor);
      },
    );
  }

  Widget _inputPassw() {
    return TextField(
      obscureText: true,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: 'Contraseña del/la docente',
          icon: Icon(Icons.lock),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onChanged: (valor) {
        setState(() {
          _passw = valor;
          code = _passw.hashCode;
        });
      },
    );
  }

  Widget _imgCentro() {
    return Image(
      image: AssetImage('assets/img/IES_ElGrao.png'),
    );
  }

  Widget _buttonNext(String rol) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.pressed)
                    ? Colors.blue[200]
                    : Colors.blue[500];
                return color;
              }),
            ),
            onPressed: () {
              //'Tutor', 'Profesor', 'Jefatura', 'Admin'
              /*   switch (rol) {
                case 'Tutor':
                  Navigator.pushNamed(context, '/TutorPage');
                  break;
                case 'Profesor':
                  Navigator.pushNamed(context, '/ProfesorPage');
                  break;
                case 'Jefatura':
                  Navigator.pushNamed(context, '/JefaturaPage');
                  break;
                case 'Admin':
                  Navigator.pushNamed(context, '/AdminPage');
                  break;
                case 'Pruebas':
                  Navigator.pushNamed(context, '/PaginaPruebas');
                  break;
                default:
              } */
              Controlador c = Controlador();
              setState(() {
                c.loginDatabase(context, _passw, _nombre);
                // Navigator.pushNamed(context, '/PaginaPruebas');
              });
            },
            child: Text('Iniciar sesión'),
          ),
        ),
      ],
    );
  }

/*  List<DropdownMenuItem<String>> getOpcionesDropDown() {
    List<DropdownMenuItem<String>> lista = [];

    _roles.forEach((rol) {
      lista.add(DropdownMenuItem(
        child: Text(rol),
        value: rol,
      ));
    });
    return lista;
  }

    Widget _crearDropDown() {
    return Row(
      children: [
        Icon(Icons.select_all),
        DropdownButton(
          value: _optSelec,
          items: getOpcionesDropDown(),
          onChanged: (opt) {
            setState(() {
              _optSelec = opt;
            });
          },
        ),
      ],
    );
  } */
}
