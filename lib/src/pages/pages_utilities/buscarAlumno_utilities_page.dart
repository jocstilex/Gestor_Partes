import 'package:flutter/material.dart';

class BuscarAlumnoPage extends StatefulWidget {
  @override
  _BuscarAlumnoPageState createState() => _BuscarAlumnoPageState();
}

class _BuscarAlumnoPageState extends State<BuscarAlumnoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Alumno Page'),
        centerTitle: true,
      ),
      body: Container(
        child: Text('Hola'),
      ),
    );
  }
}
