/* /* import 'dart:convert';

import 'package:csv/csv.dart'; */
import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
/* import 'dart:convert';
import 'dart:io'; */

// ignore: camel_case_types
class Pruebas_Page extends StatefulWidget {
  @override
  _Pruebas_PageState createState() => _Pruebas_PageState();
}

// ignore: camel_case_types
class _Pruebas_PageState extends State<Pruebas_Page> {
  Controlador c = Controlador();
  String path = '/storage/emulated/0/download/pruebas_csv.csv';
  List<List<dynamic>> l = [];

  String _nombre;
  String _dni;
  String _edad;
  List<String> h = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina pruebas'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: ListView(
            children: [
              _inpuDni('DNI'),
              _inpuNombre('Nombre'),
              _inpuEdad('Edad'),
              Text('$_nombre| $_dni | $_edad'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      _buttonDatos(),
                      SizedBox(
                        width: 2.0,
                      ),
                      _buttonInsert(_dni, _nombre, _edad),
                    ],
                  ),
                  Row(
                    children: [Expanded(child: _buttonUsus())],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonDatos() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.pressed)
              ? Colors.blue[800]
              : Colors.blue;
          return color;
        }),
      ),
      onPressed: () {},
      child: Text('Mostrar datos por terminal'),
    );
  }

  Widget _buttonInsert(String dni, String nombre, String edad) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.pressed)
              ? Colors.green[800]
              : Colors.green;
          return color;
        }),
      ),
      onPressed: () {
        FutureBuilder(
          future: c.insertBD(context, dni, nombre, edad),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return;
          },
        );
      },
      child: Text('Insertar en la BD'),
    );
  }

  Widget _inpuNombre(String hint) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        //autofocus: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            hintText: hint,
            icon: Icon(Icons.account_circle_outlined),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        onChanged: (valor) {
          setState(() => _nombre = valor);
        },
      ),
    );
  }

  Widget _inpuDni(String hint) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        //autofocus: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            hintText: hint,
            icon: Icon(Icons.account_circle_outlined),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        onChanged: (valor) {
          setState(() => _dni = valor);
        },
      ),
    );
  }

  Widget _inpuEdad(String hint) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        //autofocus: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            hintText: hint,
            icon: Icon(Icons.account_circle_outlined),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        onChanged: (valor) {
          setState(() => _edad = valor);
        },
      ),
    );
  }

  Widget _buttonUsus() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.pressed)
              ? Colors.pink[800]
              : Colors.pink;
          return color;
        }),
      ),
      onPressed: () async {
        l = await c.loadingCsvData(path);

        print('Lista L $l');
      },
      child: Text('Generar list de archivo CSV'),
    );
  }
}

/* class Alumnos {
  List<String> alumnos = [];
  Alumnos(this.alumnos);
  int i = 0;
  List<String> listAlumnos = [];

  List<String> obtenerLista() {
    alumnos.forEach((element) {
      listAlumnos.add(element);
    });
    print(listAlumnos)
    return listAlumnos;
  }
}
 */

/* import 'dart:convert';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class Pruebas_Page extends StatelessWidget {
  String path = '/storage/emulated/0/download/pruebas_csv.csv';
  List<List<dynamic>> h = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CSV DATA"),
      ),
      body: FutureBuilder(
        future: loadingCsvData(path),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          print('Lista H\n$h');
          return snapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [Text('Data cargarda')]),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Future<List<List<dynamic>>> loadingCsvData(String path) async {
    List<List<dynamic>> r = [];

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final csvFile = new File(path).openRead();
    r = await csvFile
        .transform(utf8.decoder)
        .transform(
          CsvToListConverter(),
        )
        .toList();
    print('Lista R \n$r');
    return r;
  } 
}*/
 */
