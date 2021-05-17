import 'package:flutter/material.dart';

import 'package:gestor_partes/src/widgets/botones_widgets.dart';

// ignore: must_be_immutable
class AdminPage extends StatelessWidget {
  BotonesWidgets w = BotonesWidgets();
  String _nombreCompleto;
  String dni;
  AdminPage(this.dni, this._nombreCompleto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin page'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            w.btnCrearParte(context, _nombreCompleto, dni),
            w.btnBorradores(context, _nombreCompleto, dni),
            w.btnBuscarAlumno(context),
            _boton(context, 'Gestionar Base de Datos'),
            w.btnSalir(),
          ],
        ),
      ),
    );
  }

  Widget _boton(BuildContext context, String texto) {
    return Container(
      //height: 5.0,
      padding: EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.pressed)
                      ? Colors.blue[200]
                      : Colors.blue[500];
                  return color;
                }),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/.../PaginaGestionBD');
              },
              child: Text(
                texto,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
