import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/controlador/utiles_controlador.dart';
import 'package:gestor_partes/src/widgets/botones_widgets.dart';

class BuscarAlumnoPage extends StatefulWidget {
  @override
  _BuscarAlumnoPageState createState() => _BuscarAlumnoPageState();
}

class _BuscarAlumnoPageState extends State<BuscarAlumnoPage> {
  Utiles u = Utiles();
  Controlador c = Controlador();
  BotonesWidgets btnW = BotonesWidgets();
  String _nombre, _apellido;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Alumno Page'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _inputName(),
          _inputSubName(),
          btnW.btnComprobarExistenciaAlumno(context, _nombre, _apellido),
          Card(
            child: ListTile(
              title: Text('Nombre Alumno'),
              leading: Icon(Icons.account_circle),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                c.cargarPaginaEstadisticasAlumno(context, _nombre, _apellido);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputName() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Text(
              'Nombre: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              textCapitalization: TextCapitalization.words,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _nombre = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputSubName() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Text(
              'Apellido: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              textCapitalization: TextCapitalization.words,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _apellido = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  /* Widget _muchosWidgets() {
    List<Widget> cartas = [];
    for (var i = 0; i < 5; i++) {
      Card carta = Card(
        child: ListTile(
          title: Text('Nombre Alumno'),
          leading: Icon(Icons.account_circle),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            c.cargarPaginaEstadisticasAlumno(context, _nombre, _apellido);
          },
        ),
      );
      cartas.add(carta);
    }

    return Column(
      children: [],
    );
  } */
}
