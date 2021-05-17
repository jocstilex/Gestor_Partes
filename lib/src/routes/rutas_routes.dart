import 'package:flutter/material.dart';
//import 'package:gestor_partes/src/pages/admin_page.dart';
import 'package:gestor_partes/src/pages/home_page.dart';
//import 'package:gestor_partes/src/pages/jefatura_page.dart';
//import 'package:gestor_partes/src/pages/pages_generarParte/parte1_pages_generarPartes.dart';
//import 'package:gestor_partes/src/pages/pages_generarParte/parte2_pages_generarPartes.dart';
//import 'package:gestor_partes/src/pages/pages_generarParte/parte3_pages_generarPartes.dart';
//import 'package:gestor_partes/src/pages/pages_utilities/pages_utiles_GBD/bdAlumnos_utiles_page.dart';
import 'package:gestor_partes/src/pages/pages_utilities/pages_utiles_GBD/bdImportCSV_utiles_page.dart';
//import 'package:gestor_partes/src/pages/pages_utilities/pages_utiles_GBD/bdProfesores_utiles_page.dart';
import 'package:gestor_partes/src/pages/pages_utilities/buscarAlumno_utilities_page.dart';
import 'package:gestor_partes/src/pages/pages_utilities/estadisticasAlumno_utiles_page.dart';
import 'package:gestor_partes/src/pages/pages_utilities/gestionarBD_utiles_page.dart';
//import 'package:gestor_partes/src/pages/profesor_page.dart';
import 'package:gestor_partes/src/pages/prubasbd_page.dart';
//import 'package:gestor_partes/src/pages/tutor_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
//   '/ProfesorPage': (BuildContext context) => ProfesorPage(),
    //   '/PaginaPruebas': (BuildContext context) => Pruebas_Page(),
    /*
    '/TutorPage': (BuildContext context) => TutorPage(),
    '/AdminPage': (BuildContext context) => AdminPage(),
    '/JefaturaPage': (BuildContext context) => JefaturaPage(),
 */ //  '/.../Parte1': (BuildContext context) => PartePage1(),
    '/.../BuscarAlumno': (BuildContext context) => BuscarAlumnoPage(),
//  '/.../Parte2': (BuildContext context) => PartePage2(),
//    '/.../Parte3': (BuildContext context) => Partepage3(),
    '/.../PaginaEstadisticasAlumno': (BuildContext context) =>
        EstadisticasAlumnoPage(),
    '/.../PaginaGestionBD': (BuildContext context) => GestionarBDPage(),
    // '/.../GestionBD/Alumnos': (BuildContext context) => BDGestionAlumnos(),
    /* '/.../GestionBD/Profesores': (BuildContext context) =>
        BDGestionProfesores(),*/
    '/.../GestionBD/ImportCSV': (BuildContext context) => BDGestionCSV(),
  };
}
