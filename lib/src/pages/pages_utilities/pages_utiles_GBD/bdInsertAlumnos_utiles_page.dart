import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/controlador/utiles_controlador.dart';

class InsertPageAlumnos extends StatefulWidget {
  @override
  _InsertPageAlumnosState createState() => _InsertPageAlumnosState();
}

class _InsertPageAlumnosState extends State<InsertPageAlumnos> {
  Utiles u = Utiles();
  Controlador c = Controlador();
  String _name, _subname, _curs, _nia;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            _inputNIA(),
            _inputName(),
            _inputSubName(),
            _inputCurso(),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          StadiumBorder()),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        final Color color =
                            states.contains(MaterialState.pressed)
                                ? Colors.blue[200]
                                : Colors.blue[500];
                        return color;
                      }),
                    ),
                    onPressed: () {
                      c.anyadirAlumno(context, _nia, _name, _subname, _curs);
                    },
                    child: Text('Añadir Alumno'))),
          ],
        ),
      ),
    );
  }

  Widget _inputName() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 23.0),
            child: Text(
              'Nombre: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _name = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputNIA() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 60.0),
            child: Text(
              'NIA: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _nia = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputSubName() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 12.0),
            child: Text(
              'Apellidos: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _subname = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputCurso() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 42.0),
            child: Text(
              'Curso: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _curs = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
