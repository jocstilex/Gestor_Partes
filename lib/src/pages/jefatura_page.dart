import 'package:flutter/material.dart';
import 'package:gestor_partes/src/widgets/botones_widgets.dart';

class JefaturaPage extends StatelessWidget {
  BotonesWidgets w = BotonesWidgets();
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
            w.btnCrearParte(context),
            w.btnBuscarAlumno(context),
            _boton('Generar Reporte'),
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
