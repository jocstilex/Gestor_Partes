import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/pages/pages_utilities/pages_utiles_GBD/bdAlumnos_utiles_page.dart';
import 'package:gestor_partes/src/pages/pages_utilities/pages_utiles_GBD/bdProfesores_utiles_page.dart';

// ignore: must_be_immutable
class GestionarBDPage extends StatelessWidget {
  Icon icono1 = Icon(Icons.account_tree_rounded);
  Icon icono2 = Icon(Icons.send_and_archive);
  Controlador c = Controlador();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión Base de Datos'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _listado(context, 'Importar CSV', '/.../GestionBD/ImportCSV', icono2),
          _listado(
              context, 'Gestionar Alumnos', '/.../GestionBD/Alumnos', icono1),
          _listado(context, 'Gestionar Docentes', '/.../GestionBD/Profesores',
              icono1)
        ],
      ),
    );
  }

  Widget _listado(BuildContext context, String titulo, String ruta, Icon i) {
    return Card(
      child: ListTile(
        title: Text(titulo),
        leading: i,
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          switch (titulo) {
            case 'Gestionar Alumnos':
              cargarGestionAlumnos(context);
              break;
            case 'Gestionar Docentes':
              cargarGestionDocentes(context);
              break;
            default:
          }
          // Navigator.pushNamed(context, ruta);
        },
      ),
    );
  }

  cargarGestionAlumnos(BuildContext context) async {
    List<String> nias = await c.obtenerTodosLosNia();
    String primerNombre = await c.obtenerNombre(nias[0]);
    String primerApellido = await c.obtenerApellido(nias[0]);
    String primerCurso = await c.obtenerCurso(nias[0]);

    TextEditingController nombreAlumno =
        TextEditingController(text: primerNombre);
    TextEditingController apellidoAlumno =
        TextEditingController(text: primerApellido);
    TextEditingController cursoAlumno =
        TextEditingController(text: primerCurso);
    TextEditingController niaAlumno = TextEditingController(text: nias[0]);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new BDGestionAlumnos(
          nias, nombreAlumno, apellidoAlumno, cursoAlumno, niaAlumno);
    }));
  }

  cargarGestionDocentes(BuildContext context) async {
    List<String> dnis = await c.obtenerTodosLosDNI();
    String primerNombre = await c.obtenerNombrePrimerDocente(dnis[0]);
    String primerApellido = await c.obtenerApellidoPrimerDocente(dnis[0]);
    String rol;
    bool tutoria = await c.obtenerTutorPrimerDocente(dnis[0], 'Tutor');

    bool jefatura = await c.obtenerTutorPrimerDocente(dnis[0], 'Jefatura');
    bool admin = await c.obtenerTutorPrimerDocente(dnis[0], 'Admin');
    bool profesor = await c.obtenerTutorPrimerDocente(dnis[0], 'Profesor');

    if (tutoria) rol = 'Tutor';
    if (jefatura) rol = 'Jefatura';
    if (admin) rol = 'Admin';
    if (profesor) rol = 'Profesor';

    TextEditingController nombreDocente =
        TextEditingController(text: primerNombre);
    TextEditingController apellidoDocente =
        TextEditingController(text: primerApellido);
    TextEditingController rolDocente = TextEditingController(text: rol);

    TextEditingController dniDocente = TextEditingController(text: dnis[0]);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new BDGestionProfesores(dnis, nombreDocente, apellidoDocente,
          rolDocente, tutoria, jefatura, admin, profesor, dniDocente);
    }));
  }
}
