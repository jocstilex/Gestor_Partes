import 'package:flutter/material.dart';
import 'package:gestor_partes/src/widgets/botones_widgets.dart';

// ignore: must_be_immutable
class JefaturaPage extends StatelessWidget {
  String _nombreCompleto;
  String dni;
  BotonesWidgets w = BotonesWidgets();

  JefaturaPage(this.dni, this._nombreCompleto);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jefatura page'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            w.btnCrearParte(context, _nombreCompleto, dni),
            w.btnBorradores(context, _nombreCompleto, dni),
            w.btnBuscarAlumno(context),
            _boton('Ver Estadisticas'),
            w.btnSalir(),
          ],
        ),
      ),
    );
  }

  Widget _boton(String texto) {
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
              onPressed: () {},
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
