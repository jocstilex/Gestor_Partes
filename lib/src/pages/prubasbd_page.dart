import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';

class Pruebas_Page extends StatefulWidget {
  @override
  _Pruebas_PageState createState() => _Pruebas_PageState();
}

class _Pruebas_PageState extends State<Pruebas_Page> {
  Controlador c = Controlador();
  String _nombre;
  String _dni;
  String _edad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina pruebas'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: ListView(
            children: [
              _inpuDni('DNI'),
              _inpuNombre('Nombre'),
              _inpuEdad('Edad'),
              Text('$_nombre| $_dni | $_edad'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      _buttonDatos(),
                      SizedBox(
                        width: 2.0,
                      ),
                      _buttonInsert(_dni, _nombre, _edad),
                    ],
                  ),
                  Row(
                    children: [Expanded(child: _buttonUsus())],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonDatos() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.pressed)
              ? Colors.blue[800]
              : Colors.blue;
          return color;
        }),
      ),
      onPressed: () {
        FutureBuilder(
          future: c.conexionBD(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return;
          },
        );
      },
      child: Text('Mostrar datos por terminal'),
    );
  }

  Widget _buttonInsert(String dni, String nombre, String edad) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.pressed)
              ? Colors.green[800]
              : Colors.green;
          return color;
        }),
      ),
      onPressed: () {
        FutureBuilder(
          future: c.insertBD(context, dni, nombre, edad),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return;
          },
        );
      },
      child: Text('Insertar en la BD'),
    );
  }

  Widget _inpuNombre(String hint) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        //autofocus: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            hintText: hint,
            icon: Icon(Icons.account_circle_outlined),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        onChanged: (valor) {
          setState(() => _nombre = valor);
        },
      ),
    );
  }

  Widget _inpuDni(String hint) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        //autofocus: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            hintText: hint,
            icon: Icon(Icons.account_circle_outlined),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        onChanged: (valor) {
          setState(() => _dni = valor);
        },
      ),
    );
  }

  Widget _inpuEdad(String hint) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        //autofocus: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            hintText: hint,
            icon: Icon(Icons.account_circle_outlined),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        onChanged: (valor) {
          setState(() => _edad = valor);
        },
      ),
    );
  }

  Widget _buttonUsus() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.pressed)
              ? Colors.pink[800]
              : Colors.pink;
          return color;
        }),
      ),
      onPressed: () {
        FutureBuilder(
          future: c.obtenerUsuarios(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return;
          },
        );
      },
      child: Text('Generar list'),
    );
  }
}
