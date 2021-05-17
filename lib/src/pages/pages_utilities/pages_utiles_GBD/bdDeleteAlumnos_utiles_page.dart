import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/controlador/utiles_controlador.dart';

class DeletePageAlumnos extends StatefulWidget {
  @override
  _DeletePageAlumnosState createState() => _DeletePageAlumnosState();
}

class _DeletePageAlumnosState extends State<DeletePageAlumnos> {
  String _nia;
  Utiles u = Utiles();
  Controlador c = Controlador();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _inputNIA(),
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
                      c.borrarAlumno(context, _nia);
                    },
                    child: Text('Borrar Alumno'))),
          ],
        ),
      ),
    );
  }

  Widget _inputNIA() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10.0),
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
}
