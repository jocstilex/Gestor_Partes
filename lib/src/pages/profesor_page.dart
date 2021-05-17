//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/widgets/botones_widgets.dart';

// ignore: must_be_immutable
class ProfesorPage extends StatelessWidget {
  Controlador c = Controlador();
  BotonesWidgets w = BotonesWidgets();
  String _nombreCompleto;
  String dni;
  ProfesorPage(this.dni, this._nombreCompleto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profesor page'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            // _boton('Poner Parte'),
            w.btnCrearParte(context, _nombreCompleto, dni),
            w.btnBorradores(context, _nombreCompleto, dni),
            w.btnBuscarAlumno(context),
            w.btnSalir(),
          ],
        ),
      ),
    );
  }
}
