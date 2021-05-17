import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
//import 'package:gestor_partes/src/pages/pages_generarParte/parte1_pages_generarPartes.dart';
import 'package:gestor_partes/src/widgets/botones_widgets.dart';

// ignore: must_be_immutable
class EstadistciasClase extends StatelessWidget {
  String cursoT;
  Controlador c = Controlador();
  EstadistciasClase(this.cursoT);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pruebas Clase'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: c.obtenerListaAlumnos(cursoT),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? _ListaAlumnos(snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class _ListaAlumnos extends StatelessWidget {
  Controlador c = Controlador();
  List<Map<String, dynamic>> alumnos;
  double x = 0;
  int l;
  BotonesWidgets btn = BotonesWidgets();

  _ListaAlumnos(this.alumnos);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: alumnos.length,
        itemBuilder: (BuildContext context, int i) {
          final alumno = alumnos[i];

          return FadeInLeftBig(
            delay: Duration(milliseconds: 100 * i),
            child: Card(
              child: ListTile(
                title: Text(alumno["nombre"] + ' ' + alumno["apellido"]),
                subtitle: Text('NIA: ' + alumno["nia"]),
                onTap: () async {
                  int numeroPartes =
                      await c.obtenerNumeroDePartes(alumno["nia"]);
                  btn.mostrarAlertaDatosAlumno(context, alumno["nombre"],
                      alumno["apellido"], numeroPartes);
                },
              ),
            ),
          );
        });
  }
}
