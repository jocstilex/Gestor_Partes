import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/widgets/botones_widgets.dart';

class ProfesorPage extends StatelessWidget {
  Controlador c = Controlador();
  BotonesWidgets w = BotonesWidgets();

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
            w.btnCrearParte(context),
            w.btnBuscarAlumno(context),
            w.btnSalir(),
          ],
        ),
      ),
    );
  }
}
