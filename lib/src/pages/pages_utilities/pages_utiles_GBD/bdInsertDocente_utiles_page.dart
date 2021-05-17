import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/controlador/utiles_controlador.dart';

class InsertPageDocentes extends StatefulWidget {
  @override
  _InsertPageDocentesState createState() => _InsertPageDocentesState();
}

class _InsertPageDocentesState extends State<InsertPageDocentes> {
  Utiles u = Utiles();
  Controlador c = Controlador();
  String _name, _subname, _rol, _dni, _claseT;
  bool tutor = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            _inputDNI(),
            _inputName(),
            _inputSubName(),
            _inputRol(),
            _crearCheckBox1(),
            _inputTurotia(),
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
                      c.anyadirDocente(
                          context, _dni, _name, _subname, _rol, tutor, _claseT);
                    },
                    child: Text('Añadir Docente'))),
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
              // keyboardType: TextInputType.number,
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

  Widget _inputDNI() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 60.0),
            child: Text(
              'DNI: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              //keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _dni = valor;
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
              //keyboardType: TextInputType.number,
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

  Widget _inputRol() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 70.0),
            child: Text(
              'Rol: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              //  keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _rol = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  _crearCheckBox1() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blueAccent)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Es tutor',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 80.0),
                    child: Checkbox(
                      value: tutor,
                      onChanged: (valor) {
                        setState(() {
                          tutor = valor;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _inputTurotia() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Text(
              'Clase a la que tutela: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              enabled: tutor,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _claseT = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
