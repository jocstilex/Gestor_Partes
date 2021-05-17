import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/widgets/botones_widgets.dart';

// ignore: must_be_immutable
class TutorPage extends StatefulWidget {
  String _nombreCompleto;
  String cursoT;
  String dni;
  int _num = 0;
  TutorPage(this.dni, this._nombreCompleto, this.cursoT, this._num);

  @override
  _TutorPageState createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  BotonesWidgets w = BotonesWidgets();
  Controlador c = Controlador();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutor_Page'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            w.btnCrearParte(context, widget._nombreCompleto, widget.dni),
            w.btnBorradores(context, widget._nombreCompleto, widget.dni),
            w.btnBuscarAlumno(context),
            w.botonEstadisticasClase(
                context, 'Estadisticas Clase', widget.cursoT),
            w.btnSalir(),
          ],
        ),
      ),
      floatingActionButton: _alerts(),
    );
  }

  Widget _alerts() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
                color: Colors.blue[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70.0)),
                elevation: 30.0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 50.0, left: 20.0),
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          widget._num.toString(),
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        )),
                    Container(
                      padding: EdgeInsets.only(right: 10.0),
                      child: FloatingActionButton(
                        backgroundColor: Colors.blue[300],
                        elevation: 0,
                        onPressed: () async {
                          c.resetAlertas(widget.dni);
                          widget._num = await c.obtenerAlertas(widget.dni);
                          setState(() {});
                        },
                        child:
                            Icon(Icons.add_alert_outlined, color: Colors.white),
                        //textColor: Colors.white,
                        // color: Colors.red[700],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ],
    );
  }
}
