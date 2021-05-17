import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/pages/pages_generarParte/parte1_pages_generarPartes.dart';

// ignore: must_be_immutable
class BorradoresPartes extends StatelessWidget {
  String nombreProfesor;
  String dni;
  Controlador c = Controlador();
  BorradoresPartes(this.nombreProfesor, this.dni);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pruebas borradores'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: c.obtenerPartesSinAcabarMAP(nombreProfesor, dni),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? _ListaBorradores(snapshot.data, dni)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class _ListaBorradores extends StatelessWidget {
  Controlador c = Controlador();
  List<Map<String, dynamic>> borradores;
  double x = 0;
  int l;
  String dni;

  _ListaBorradores(this.borradores, this.dni);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: borradores.length,
        itemBuilder: (BuildContext context, int i) {
          final borrador = borradores[i];
          x = borrador["numparte"];
          l = x.toInt();
          return FadeInLeftBig(
            delay: Duration(milliseconds: 100 * i),
            child: Card(
              child: ListTile(
                title: Text('Parte $l'),
                subtitle: Text('Profesor: ' +
                    borrador["dni"] +
                    '\nAlumno: ' +
                    borrador["nia"]),
                onTap: () async {
                  String nombreDocente =
                      await c.obtenerNombreDocente(borrador["dni"]);

                  List<String> listaAlumnos1eso = [];
                  String primerAlumno;
                  TextEditingController nombreDoc =
                      TextEditingController(text: nombreDocente);

                  listaAlumnos1eso = await c.listaAlumnos('1ESO');
                  primerAlumno = await c.obtenerNombre(borrador["nia"]);
                  primerAlumno = primerAlumno +
                      ' ' +
                      await c.obtenerApellido(borrador["nia"]);
                  String curso = await c.obtenerCurso(borrador["nia"]);

                  List<bool> tip = await c
                      .obtenerTipificaciones(borrador["numparte"].toInt());

                  TextEditingController nombreAL =
                      TextEditingController(text: primerAlumno);
                  TextEditingController cursoAL =
                      TextEditingController(text: curso);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return new PartePage1(
                        dni,
                        borrador["numparte"].toInt(),
                        nombreDoc,
                        listaAlumnos1eso,
                        primerAlumno,
                        nombreAL,
                        cursoAL,
                        tip[0],
                        tip[1],
                        tip[2],
                        tip[3],
                        tip[4],
                        tip[5],
                        tip[6],
                        tip[7],
                        tip[8],
                        tip[9],
                        tip[10],
                        tip[11],
                        tip[12],
                        tip[13],
                        tip[14],
                        tip[15]);
                  }));
                },
              ),
            ),
          );
        });
  }
}
