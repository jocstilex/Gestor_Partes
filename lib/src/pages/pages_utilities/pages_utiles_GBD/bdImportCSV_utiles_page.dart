import 'package:flutter/material.dart';

class BDGestionCSV extends StatefulWidget {
  @override
  _BDGestionCSVState createState() => _BDGestionCSVState();
}

class _BDGestionCSVState extends State<BDGestionCSV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión CSV'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 200.0),
          child: Column(children: [
            ElevatedButton(
                onPressed: () {}, child: Text('Insertar Profesores')),
            ElevatedButton(onPressed: () {}, child: Text('Insertar Alumnos'))
          ]),
        ),
      ),
    );
  }
}
