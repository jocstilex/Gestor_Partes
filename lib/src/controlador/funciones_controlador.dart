import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:gestor_partes/src/controlador/medidaED.dart';
import 'package:gestor_partes/src/controlador/tipificacion.dart';
import 'package:gestor_partes/src/pages/admin_page.dart';
import 'package:gestor_partes/src/pages/jefatura_page.dart';
import 'package:gestor_partes/src/pages/profesor_page.dart';
import 'package:gestor_partes/src/pages/tutor_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:postgres/postgres.dart';

import 'parte.dart';

class Controlador {
  Controlador();
  String ip = '192.168.1.97';

  //Función de loggin que se conecta a la base de datos y busca si
  // existe el usuario al que se le han insertado los datos
  Future loginDatabase(BuildContext context, String dni, String nombre) async {
    bool acceso = false;
    // bool tutor = false;
    String rol = '';
    String nombreCompleto = await obtenerNombreDocente(dni);

    //  TextEditingController nco = TextEditingController(text: nombreCompleto);

    //Conexion a la base de datos postgres
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    print('Conectandose a la base de datos....');

    //Busqueda de los datos
    List<List<dynamic>> results =
        await connection.query("SELECT dni,nombre,rol FROM docente");

    //Bucle que recorre los datos de las columnas obtenidas
    for (final row in results) {
      //DNI
      var a = row[0];
      //Nombre
      var b = row[1];
      //Rol

      //Check de los datos
      if (dni == a && nombre == b) {
        acceso = true;
        rol = row[2];
      }
    }

    //Casos de acción segun el resultado true fals o nulls
    if (acceso) {
      switch (rol) {
        case 'Profesor':
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return new ProfesorPage(dni, nombreCompleto);
          }));
          break;
        case 'Jefatura':
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return new JefaturaPage(dni, nombreCompleto);
          }));
          break;
        case 'Admin':
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return new AdminPage(dni, nombreCompleto);
          }));
          break;
        case 'Tutor':
          String cursoT;
          int alerta;
          cursoT = await obtenerClaseT(dni);
          alerta = await obtenerAlertas(dni);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return new TutorPage(dni, nombreCompleto, cursoT, alerta);
          }));
          break;
        default:
      }
    } else if (dni == null || nombre == null) {
      final snackBar = SnackBar(
        content: Text('Hay datos sin introducir'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Error al introducir los datos'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    //Fin de la conexión a la base de datos
    await connection.close();
    print('Conexion finalizada');
  }

  Future insertBD(
      BuildContext context, String dni, String nombre, String edad) async {
    int numedad = int.parse(edad);

    var connection = PostgreSQLConnection(ip, 5432, "prueba",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    await connection.transaction((ctx) async {
      await ctx.query(
          "INSERT INTO tabla_prueba (dni,nombre,edad) VALUES (@dni,@nombre,@edad)",
          substitutionValues: {"dni": dni, "nombre": nombre, "edad": numedad});
    });

    final snackBar = SnackBar(
      content: Text('Usuario añadido'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    await connection.close();
    print('Conexión finalizada');
  }

  Future conexionBD() async {
    // Map lista = new Map<String, dynamic>();

    var connection = PostgreSQLConnection(ip, 5432, "prueba",
        username: "postgres", password: "postgres");
    await connection.open();
    print('Conectandose a la base de datos....');

    List<List<dynamic>> results =
        await connection.query("SELECT dni,nombre,edad FROM tabla_prueba");

    for (final row in results) {
      var a = row[0];
      var b = row[1];
      var c = row[2];
      print('Esto es A: $a');
      print('Esto es B: $b');
      print('Esto es C: $c');
    }
    //print(results.toString());

    await connection.close();
    print('Conexion finalizada');
  }

  Future<List<Map<String, dynamic>>> obtenerPartesSinAcabarMAP(
      String nombreProfesor, String dni) async {
    List<Map<String, dynamic>> partes = [];
    Map<String, dynamic> partesbd;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    print('Conectandose a la base de datos....');

    List<List<dynamic>> results = await connection.query(
        "SELECT dni,nia,num_parte FROM docente_parte_alumno WHERE dni = '$dni' AND num_parte IN(SELECT numparte FROM parte WHERE nombre_profesor = '$nombreProfesor' AND finalizado = 'false ')");

    for (final row in results) {
      String a = row[0];
      String b = row[1];
      double c = row[2];

      partesbd = {"dni": a, "nia": b, "numparte": c};

      partes.add(partesbd);
    }

    for (int x = 0; x < partes.length; x++) {
      Map<String, dynamic> prueba = partes[x];
      print('DNI:' + prueba["dni"]);
      print('NIA:' + prueba["nia"]);
      double numParte = prueba["numparte"];
      print('NumParte: $numParte');
    }
    await connection.close();
    print('Conexion finalizada');
    return partes;
  }

  Future<List<Map<String, dynamic>>> obtenerListaAlumnos(String cursoT) async {
    //Función que se conecta a la base de dtaos, recoge todos los usuarios
    //y lo almacena en un array de Map<String,dynamic>
    //de esta forma podemos acceder a todos los usuarios y datos desde la
    //aplicación.
    //Con esto podremos crear tantos wisgets como usuarios queramos

    //Creamos las variables de array y Map
    List<Map<String, dynamic>> alumnos = [];
    Map<String, dynamic> alumnosbd;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    print('Conectandose a la base de datos....');

    //WHERE dni = '$dni' AND num_parte IN(SELECT numparte FROM parte WHERE nombre_profesor = '$nombreProfesor' AND finalizado = 'false ')
    List<List<dynamic>> results = await connection.query(
        "SELECT nia,nombre,apellido FROM alumno WHERE curso = '$cursoT' ");

    for (final row in results) {
      String a = row[0];
      String b = row[1];
      String c = row[2];

      alumnosbd = {"nia": a, "nombre": b, "apellido": c};

      alumnos.add(alumnosbd);
    }

    //Ahora podemos recorrer el array, y cada iteración es un map con dni,nombre, y edad
    for (int x = 0; x < alumnos.length; x++) {
      //Creamos un Map donde guardar las iteraciones de Maps
      //Y ya podemos usar los datos guardados en los Maps
      Map<String, dynamic> prueba = alumnos[x];
      print('NIA:' + prueba["nia"]);
      print('Nombre:' + prueba["nombre"]);

      print('Apellido: ' + prueba["apellido"]);
    }
    await connection.close();
    print('Conexion finalizada');
    return alumnos;
  }

  void mostrarDatos(String object) {
    print(object);
  }

  Future buscarAlumno(
      BuildContext context, String nombre, String apellidos) async {
    bool existe = false;

    //Conexion a la base de datos postgres
    var connection = PostgreSQLConnection(ip, 5432, "prueba",
        username: "postgres", password: "postgres");
    await connection.open();
    print('Conectandose a la base de datos....');

    //Busqueda de los datos
    List<List<dynamic>> results =
        await connection.query("SELECT nombre,apellidos FROM alumnos");

    //Bucle que recorre los datos de las columnas obtenidas
    for (final row in results) {
      //Primera columna
      var a = row[0];
      //Segunda columna
      var b = row[1];

      //Check de los datos
      if (nombre == a && apellidos == b) existe = true;
    }

    //Casos de acción segun el resultado true fals o nulls
    if (existe) {
      final snackBar = SnackBar(
        content: Text('El alumno existe'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //Navigator.pushNamed(context, '/PaginaPruebas');
    } else if (nombre == null || apellidos == null) {
      final snackBar = SnackBar(
        content: Text('Hay datos sin introducir'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('El alumno no existe en la base de datos'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    //Fin de la conexión a la base de datos
    await connection.close();
    print('Conexion finalizada');
  }

  cargarPaginaEstadisticasAlumno(
      BuildContext context, String nombre, String apellido) {
    Navigator.pushNamed(context, '/.../PaginaEstadisticasAlumno');
  }

  Future<List<String>> listaAlumnos(String cursoselec) async {
    List<String> listaAlumnos = [];
    String alumno;

    //Conexion a la base de datos postg res
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    print('Conectandose a la base de datos....');

    //Busqueda de los datos
    List<List<dynamic>> results = await connection.query(
        "SELECT nombre,apellido FROM alumno WHERE curso = '$cursoselec'");

    //Bucle que recorre los datos de las columnas obtenidas
    for (final row in results) {
      //Primera columna = nombre
      var a = row[0];
      //Segunda columna = apellidos
      var b = row[1];
      alumno = a + ' ' + b;
      listaAlumnos.add(alumno);
    }

    //Fin de la conexión a la base de datos
    await connection.close();

    print('Conexion finalizada');
    // print(listaAlumnos);
    return listaAlumnos;
  }

  Future borrarAlumno(BuildContext context, String nia) async {
    bool existe = false;
    // Map lista = new Map<String, dynamic>();

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");

    await connection.open();

    print('Conectandose a la base de datos....');

    await connection.execute("DELETE FROM alumno WHERE nia = '$nia'");
    existe = await existenciaAlumno(nia);

    if (existe) {
      final snackBar = SnackBar(
        content: Text('Fallo al borrar alumno'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Alumno borrado correctamente'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    //print(results.toString());

    await connection.close();
    print('Conexion finalizada');
  }

  Future borrarDocente(BuildContext context, String dni) async {
    bool existe = false;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    await connection.execute("DELETE FROM alumno WHERE nia = '$dni'");
    existe = await existenciaDocente(dni);

    if (existe) {
      final snackBar = SnackBar(
        content: Text('Fallo al borrar docente'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Docente borrado correctamente'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    //print(results.toString());

    await connection.close();
    print('Conexion finalizada');
  }

  Future anyadirAlumno(
      BuildContext context, String nia, name, subname, curs) async {
    bool existe = false;
    // Map lista = new Map<String, dynamic>();

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");

    await connection.open();

    print('Conectandose a la base de datos....');

    await connection.execute(
        "INSERT INTO alumno (nia,nombre,apellido,curso) VALUES('$nia','$name','$subname','$curs')");

    existe = await existenciaAlumno(nia);

    if (existe) {
      final snackBar = SnackBar(
        content: Text('Alumno introducido correctamente'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Fallo al introducir en la base de datos'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    await connection.close();
    print('Conexion finalizada');
  }

  Future anyadirDocente(BuildContext context, String dni, name, subname, rol,
      bool tutor, String cursoT) async {
    bool existe = false;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    if (tutor) {
      await connection.execute(
          "COMMIT;BEGIN TRANSACTION;INSERT INTO docente (dni,nombre,apellidos,rol) VALUES('$dni','$name','$subname','$rol');INSERT INTO tutor (dni,curso_tutoria)VALUES('$dni','$cursoT');COMMIT;");
    } else {
      await connection.execute(
          "COMMIT;BEGIN TRANSACTION;INSERT INTO docente (dni,nombre,apellidos,rol) VALUES('$dni','$name','$subname','$rol');INSERT INTO no_tutor (dni)VALUES('$dni');COMMIT;");
    }
    existe = await existenciaDocente(dni);

    if (existe) {
      final snackBar = SnackBar(
        content: Text('Docente introducido correctamente'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Fallo al introducir en la base de datos'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    await connection.close();
    print('Conexion finalizada');
  }

  Future<bool> existenciaAlumno(String nia) async {
    bool existe = false;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    List<List<dynamic>> results =
        await connection.query("SELECT nia FROM alumno");

    //Bucle que recorre los datos de las columnas obtenidas
    for (final row in results) {
      //DNI
      var a = row[0];

      //Check de los datos
      if (nia == a) {
        existe = true;
      }
      //print(results.toString());

    }
    await connection.close();
    return existe;
  }

  Future<bool> existenciaDocente(String dni) async {
    bool existe = false;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    List<List<dynamic>> results =
        await connection.query("SELECT dni FROM docente");

    //Bucle que recorre los datos de las columnas obtenidas
    for (final row in results) {
      //DNI
      var a = row[0];

      //Check de los datos
      if (dni == a) {
        existe = true;
      }
      //print(results.toString());

    }
    await connection.close();
    return existe;
  }

  Future insertarParte(String dni, Parte parte,
      List<Tipificacion> tipificaciones, List<MedidaED> medidasED) async {
    int numeroParte = parte.getNumParte();

    String nia = parte.getNia();
    String nombreSancionado = parte.getNombreSancionado();
    String grupoSancioando = parte.getGrupoSancioando();
    String nombreProfesor = parte.getNombreProfesor();
    String descripcionparte = parte.getDescripcion();
    String fecha = parte.getFecha();
    String hora = parte.getHora();
    String observacionComTel = parte.getObservacionComTel();
    String fechaComTel = parte.getFechaComTel();
    bool existe = true;
    bool existeT;

    if (observacionComTel == null) observacionComTel = '';
    if (fechaComTel == null) fechaComTel = '';

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');
    //Insert en la tabla parte
    existe = await comprobarExistenciaParte(numeroParte);

    if (existe == false) {
      await connection.execute(
          "INSERT INTO parte (numparte,nom_sancionado,grupo_sancionado,nombre_profesor,descripcion,hora,fecha,observacion_com_telefonica,fecha_com_telefonica,finalizado) VALUES('$numeroParte','$nombreSancionado','$grupoSancioando','$nombreProfesor','$descripcionparte','$hora','$fecha','$observacionComTel','$fechaComTel',true)");
    } else {
      await connection.execute(
          "UPDATE parte SET nom_sancionado = '$nombreSancionado',grupo_sancionado = '$grupoSancioando',nombre_profesor = '$nombreProfesor',descripcion = '$descripcionparte',hora = '$hora',fecha = '$fecha',observacion_com_telefonica = '$descripcionparte',fecha_com_telefonica = '$fechaComTel', finalizado = true WHERE numparte = $numeroParte");
    }

    //Insert en la tabla tipificaciones

    /* 
      Fallo en el bucle + await (Se cierra el StreaInk)
      Revisar en depuración
    
     tipificaciones.forEach((tipificacion) async {
      if (tipificacion.getValor()) {
        int numerTipificacion = tipificacion.getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    }); 
*/

    existeT = await comprobarExistenciaTipificacion(numeroParte, 1);

    if (existeT == false) {
      if (tipificaciones[0].getValor()) {
        int numerTipificacion = tipificaciones[0].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[0].getValor() == false) {
        int numerTipificacion = tipificaciones[0].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 2);
    if (existeT == false) {
      if (tipificaciones[1].getValor()) {
        int numerTipificacion = tipificaciones[1].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[1].getValor() == false) {
        int numerTipificacion = tipificaciones[1].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 3);
    if (existeT == false) {
      if (tipificaciones[2].getValor()) {
        int numerTipificacion = tipificaciones[2].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[2].getValor() == false) {
        int numerTipificacion = tipificaciones[2].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 4);
    if (existeT == false) {
      if (tipificaciones[3].getValor()) {
        int numerTipificacion = tipificaciones[3].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[3].getValor() == false) {
        int numerTipificacion = tipificaciones[3].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 5);
    if (existeT == false) {
      if (tipificaciones[4].getValor()) {
        int numerTipificacion = tipificaciones[4].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[4].getValor() == false) {
        int numerTipificacion = tipificaciones[4].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 6);
    if (existeT == false) {
      if (tipificaciones[5].getValor()) {
        int numerTipificacion = tipificaciones[5].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[5].getValor() == false) {
        int numerTipificacion = tipificaciones[5].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 7);
    if (existeT == false) {
      if (tipificaciones[6].getValor()) {
        int numerTipificacion = tipificaciones[6].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[6].getValor() == false) {
        int numerTipificacion = tipificaciones[6].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 8);
    if (existeT == false) {
      if (tipificaciones[7].getValor()) {
        int numerTipificacion = tipificaciones[7].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[7].getValor() == false) {
        int numerTipificacion = tipificaciones[7].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 9);
    if (existeT == false) {
      if (tipificaciones[8].getValor()) {
        int numerTipificacion = tipificaciones[8].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[8].getValor() == false) {
        int numerTipificacion = tipificaciones[8].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }

    existeT = await comprobarExistenciaTipificacion(numeroParte, 10);
    if (existeT == false) {
      if (tipificaciones[9].getValor()) {
        int numerTipificacion = tipificaciones[9].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[9].getValor() == false) {
        int numerTipificacion = tipificaciones[9].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 11);
    if (existeT == false) {
      if (tipificaciones[10].getValor()) {
        int numerTipificacion = tipificaciones[10].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[10].getValor() == false) {
        int numerTipificacion = tipificaciones[10].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 12);
    if (existeT == false) {
      if (tipificaciones[11].getValor()) {
        int numerTipificacion = tipificaciones[11].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[11].getValor() == false) {
        int numerTipificacion = tipificaciones[11].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 13);
    if (existeT == false) {
      if (tipificaciones[12].getValor()) {
        int numerTipificacion = tipificaciones[12].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[12].getValor() == false) {
        int numerTipificacion = tipificaciones[12].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 14);
    if (existeT == false) {
      if (tipificaciones[13].getValor()) {
        int numerTipificacion = tipificaciones[13].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[13].getValor() == false) {
        int numerTipificacion = tipificaciones[13].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 15);
    if (existeT == false) {
      if (tipificaciones[14].getValor()) {
        int numerTipificacion = tipificaciones[14].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[14].getValor() == false) {
        int numerTipificacion = tipificaciones[14].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }
    existeT = await comprobarExistenciaTipificacion(numeroParte, 16);
    if (existeT == false) {
      if (tipificaciones[15].getValor()) {
        int numerTipificacion = tipificaciones[15].getNumeroTipificacion();
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
    } else {
      if (tipificaciones[15].getValor() == false) {
        int numerTipificacion = tipificaciones[15].getNumeroTipificacion();
        await connection.execute(
            "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
      }
    }

    /*  
    Fallo en el bucle + await (Se cierra el StreaInk)
    Revisar en depuración

         medidasED.forEach((medida) async {
      if (medida.getValor()) {
        int numeroMedida = medida.getNumeroMedidaED();
        String fechaIni = medida.getFechaInicio();
        String fechaFin = medida.getFechaFinal();
        await connection.execute(
            "INSERT INTO parte_medidaed (num_parte,num_medida_ed,fecha_inicio,fecha_final) VALUES('$numeroParte','$numeroMedida','$fechaIni','$fechaFin')");
      }
    });  */

    if (medidasED[0].getValor()) {
      int numeroMedida = medidasED[0].getNumeroMedidaED();
      String fechaIni = '';
      String fechaFin = '';
      await connection.execute(
          "INSERT INTO parte_medidaed (num_parte,num_medida_ed,fecha_inicio,fecha_final) VALUES('$numeroParte','$numeroMedida','$fechaIni','$fechaFin')");
    }

    if (medidasED[1].getValor()) {
      int numeroMedida = medidasED[1].getNumeroMedidaED();
      String fechaIni = medidasED[1].getFechaInicio();
      String fechaFin = medidasED[1].getFechaFinal();
      await connection.execute(
          "INSERT INTO parte_medidaed (num_parte,num_medida_ed,fecha_inicio,fecha_final) VALUES('$numeroParte','$numeroMedida','$fechaIni','$fechaFin')");
    }
    if (medidasED[2].getValor()) {
      int numeroMedida = medidasED[2].getNumeroMedidaED();
      String fechaIni = medidasED[2].getFechaInicio();
      String fechaFin = medidasED[2].getFechaFinal();
      await connection.execute(
          "INSERT INTO parte_medidaed (num_parte,num_medida_ed,fecha_inicio,fecha_final) VALUES('$numeroParte','$numeroMedida','$fechaIni','$fechaFin')");
    }
    if (medidasED[3].getValor()) {
      int numeroMedida = medidasED[3].getNumeroMedidaED();
      String fechaIni = medidasED[3].getFechaInicio();
      String fechaFin = medidasED[3].getFechaFinal();
      await connection.execute(
          "INSERT INTO parte_medidaed (num_parte,num_medida_ed,fecha_inicio,fecha_final) VALUES('$numeroParte','$numeroMedida','$fechaIni','$fechaFin')");
    }
    if (medidasED[4].getValor()) {
      int numeroMedida = medidasED[4].getNumeroMedidaED();
      String fechaIni = medidasED[4].getFechaInicio();
      String fechaFin = medidasED[4].getFechaFinal();
      await connection.execute(
          "INSERT INTO parte_medidaed (num_parte,num_medida_ed,fecha_inicio,fecha_final) VALUES('$numeroParte','$numeroMedida','$fechaIni','$fechaFin')");
    }
    if (medidasED[5].getValor()) {
      int numeroMedida = medidasED[5].getNumeroMedidaED();
      String fechaIni = medidasED[5].getFechaInicio();
      String fechaFin = medidasED[5].getFechaFinal();
      await connection.execute(
          "INSERT INTO parte_medidaed (num_parte,num_medida_ed,fecha_inicio,fecha_final) VALUES('$numeroParte','$numeroMedida','$fechaIni','$fechaFin')");
    }
    if (medidasED[6].getValor()) {
      int numeroMedida = medidasED[6].getNumeroMedidaED();
      String fechaIni = medidasED[6].getFechaInicio();
      String fechaFin = medidasED[6].getFechaFinal();
      await connection.execute(
          "INSERT INTO parte_medidaed (num_parte,num_medida_ed,fecha_inicio,fecha_final) VALUES('$numeroParte','$numeroMedida','$fechaIni','$fechaFin')");
    }
    if (medidasED[7].getValor()) {
      int numeroMedida = medidasED[7].getNumeroMedidaED();
      String fechaIni = medidasED[7].getFechaInicio();
      String fechaFin = medidasED[7].getFechaFinal();
      await connection.execute(
          "INSERT INTO parte_medidaed (num_parte,num_medida_ed,fecha_inicio,fecha_final) VALUES('$numeroParte','$numeroMedida','$fechaIni','$fechaFin')");
    }

    if (existe == false) {
      await connection.execute(
          "INSERT INTO docente_parte_alumno (dni,num_parte,nia) VALUES('$dni','$numeroParte','$nia')");
    } else {
      await connection.execute(
          "UPDATE docente_parte_alumno SET dni = '$dni',num_parte = '$numeroParte' ,nia = '$nia' WHERE num_parte = '$numeroParte'");
    }

    int alerta;
    List<List<dynamic>> results = await connection.query(
        "SELECT alertas FROM docente WHERE clase_t = '$grupoSancioando'");

    for (final row in results) {
      int a = row[0].toInt();

      alerta = a;
      alerta++;
    }

    await connection.execute(
        "UPDATE docente SET alertas = '$alerta' WHERE clase_t = '$grupoSancioando'");

    await connection.close();
    print('Conexion finalizada');
  }

  Future<String> obtenerNIA(String nombreSancionado, String curso) async {
    String nia;
    String nombre;
    String apellido;

    var particion = nombreSancionado.split(' ');

    nombre = particion[0];
    apellido = particion[1] + ' ' + particion[2];

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    List<List<dynamic>> results = await connection.query(
        "SELECT nia FROM alumno WHERE nombre = '$nombre' AND apellido = '$apellido'AND curso = '$curso'");

    for (final row in results) {
      String a = row[0];

      nia = a;
    }

    await connection.close();
    print('Conexion finalizada');
    return nia;
  }

  /*  Future<String> obtenerDNI(String nombreProfesor) async {
    String dni;
    String nombre;
    String apellido;

    var particion = nombreProfesor.split(' ');

    nombre = particion[0];
    apellido = particion[1] + ' ' + particion[2];

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    List<List<dynamic>> results = await connection.query(
        "SELECT dni FROM docente WHERE nombre = '$nombre' AND apellidos = '$apellido'");

    for (final row in results) {
      String a = row[0];

      dni = a;
    }

    await connection.close();
    print('Conexion finalizada');
    return dni;
  } */

  Future<String> obtenerNombreDocente(String contrasenya) async {
    String nombre;
    String apellido;
    String nombreCompleto;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    List<List<dynamic>> results = await connection.query(
        "SELECT nombre,apellidos FROM docente WHERE dni = '$contrasenya'");

    for (final row in results) {
      String a = row[0];
      String b = row[1];

      nombre = a;
      apellido = b;
    }
    nombreCompleto = nombre + ' ' + apellido;
    await connection.close();
    print('Conexion finalizada');
    return nombreCompleto;
  }

  Future<int> obtenerNumParte() async {
    int numParte;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    List<List<dynamic>> results = await connection.query(
        "SELECT numparte FROM parte WHERE numparte >= all (SELECT numparte FROM parte)");

    for (final row in results) {
      double a = row[0];

      numParte = a.toInt();
    }

    await connection.close();
    print('Conexion finalizada');
    numParte++;
    return numParte;
  }

  Future<List<String>> obtenerTodosLosNia() async {
    List<String> nias = [];
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    print('Conectandose a la base de datos....');

    //Busqueda de los datos
    List<List<dynamic>> results =
        await connection.query("SELECT nia FROM alumno");

    //Bucle que recorre los datos de las columnas obtenidas
    for (final row in results) {
      var a = row[0];
      nias.add(a);
    }
    await connection.close();
    return nias;
  }

  Future<String> obtenerNombre(String nia) async {
    String nombre;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    List<List<dynamic>> results =
        await connection.query("SELECT nombre FROM alumno WHERE nia = '$nia'");

    for (final row in results) {
      String a = row[0];

      nombre = a;
    }

    await connection.close();
    print('Conexion finalizada');
    return nombre;
  }

  Future<String> obtenerApellido(String nia) async {
    String apellido;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    List<List<dynamic>> results = await connection
        .query("SELECT apellido FROM alumno WHERE nia = '$nia'");

    for (final row in results) {
      String a = row[0];

      apellido = a;
    }

    await connection.close();
    print('Conexion finalizada');
    return apellido;
  }

  Future<String> obtenerCurso(String nia) async {
    String curso;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    List<List<dynamic>> results =
        await connection.query("SELECT curso FROM alumno WHERE nia = '$nia'");

    for (final row in results) {
      String a = row[0];

      curso = a;
    }

    await connection.close();
    print('Conexion finalizada');
    return curso;
  }

  modificarAlumno(BuildContext context, String nian, String niav, String nombre,
      String apellidos, String curso) async {
    String a, b, c, d;
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');
    connection.execute(
        "UPDATE alumno SET nia ='$nian',nombre = '$nombre',apellido = '$apellidos',curso = '$curso'WHERE nia = '$niav'");

    List<List<dynamic>> results = await connection.query(
        "SELECT nia,nombre,apellido,curso FROM alumno WHERE nia = '$nian'");

    for (final row in results) {
      a = row[0];
      b = row[1];
      c = row[2];
      d = row[3];
    }
    if (nian == a && nombre == b && apellidos == c && curso == d) {
      final snackBar = SnackBar(
        content: Text('Alumno modificado correctamente'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Error al modificar al alumno'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    await connection.close();
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

  getTransaction(List<List<dynamic>> listaCSV) {
    listaCSV.forEach((element) {});
  }

  Future<List<String>> obtenerTodosLosDNI() async {
    List<String> dnis = [];
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    print('Conectandose a la base de datos....');

    //Busqueda de los datos
    List<List<dynamic>> results =
        await connection.query("SELECT dni FROM docente");

    //Bucle que recorre los datos de las columnas obtenidas
    for (final row in results) {
      var a = row[0];
      dnis.add(a);
    }
    await connection.close();
    return dnis;
  }

  Future<String> obtenerNombrePrimerDocente(String dni) async {
    String nombre;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    List<List<dynamic>> results =
        await connection.query("SELECT nombre FROM docente WHERE dni = '$dni'");

    for (final row in results) {
      String a = row[0];

      nombre = a;
    }

    await connection.close();
    print('Conexion finalizada');
    return nombre;
  }

  Future<String> obtenerApellidoPrimerDocente(String dni) async {
    String apellido;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    List<List<dynamic>> results = await connection
        .query("SELECT apellidos FROM docente WHERE dni = '$dni'");

    for (final row in results) {
      String a = row[0];

      apellido = a;
    }

    await connection.close();
    print('Conexion finalizada');
    return apellido;
  }

  Future<bool> obtenerTutorPrimerDocente(String dni, String rolAs) async {
    String rol;
    bool esRol = false;

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    List<List<dynamic>> results =
        await connection.query("SELECT rol FROM docente WHERE dni = '$dni'");

    for (final row in results) {
      String a = row[0];

      rol = a;
    }

    if (rol == rolAs) {
      esRol = true;
    }

    await connection.close();
    print('Conexion finalizada');
    return esRol;
  }

  modificarDocente(BuildContext context, String dnin, String dniv,
      String nombre, String apellidos, String rol, String claseT) async {
    String a, b, c, d, e;
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    if (rol != 'Tutor') {
      print('Conectandose a la base de datos....');
      connection.execute(
          "UPDATE docente SET dni ='$dnin',nombre = '$nombre',apellidos = '$apellidos',rol = '$rol', clase_t = '' WHERE dni = '$dniv'");

      List<List<dynamic>> results = await connection.query(
          "SELECT dni,nombre,apellidos,rol FROM docente WHERE dni = '$dnin'");

      for (final row in results) {
        a = row[0];
        b = row[1];
        c = row[2];
        d = row[3];
      }
      if (dnin == a && nombre == b && apellidos == c && rol == d) {
        final snackBar = SnackBar(
          content: Text('Docente modificado correctamente'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('Error al modificar al docente'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print('Conectandose a la base de datos....');
      connection.execute(
          "UPDATE docente SET dni ='$dnin',nombre = '$nombre',apellidos = '$apellidos',rol = '$rol', clase_t = '$claseT' WHERE dni = '$dniv'");

      List<List<dynamic>> results = await connection.query(
          "SELECT dni,nombre,apellidos,rol,clase_t FROM docente WHERE dni = '$dnin'");

      for (final row in results) {
        a = row[0];
        b = row[1];
        c = row[2];
        d = row[3];
        e = row[4];
      }
      if (dnin == a &&
          nombre == b &&
          apellidos == c &&
          rol == d &&
          claseT == e) {
        final snackBar = SnackBar(
          content: Text('Docente modificado correctamente'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('Error al modificar al docente'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    await connection.close();
  }

  Future<String> obtenerClaseDocente(String dni, bool tutor) async {
    String claseT = '';
    if (tutor) {
      var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
          username: "postgres", password: "postgres");
      await connection.open();

      print('Conectandose a la base de datos....');

      List<List<dynamic>> results = await connection
          .query("SELECT clase_t FROM docente WHERE dni = '$dni'");

      for (final row in results) {
        String a = row[0];

        claseT = a;
      }
      await connection.close();
    } else {
      return claseT;
    }

    print('Conexion finalizada');
    return claseT;
  }

  Future guardarParteP1(
      int numeroParte,
      String dni,
      bool tip1,
      bool tip2,
      bool tip3,
      bool tip4,
      bool tip5,
      bool tip6,
      bool tip7,
      bool tip8,
      bool tip9,
      bool tip10,
      bool tip11,
      bool tip12,
      bool tip13,
      bool tip14,
      bool tip15,
      bool tip16,
      String nombreSancionado,
      String grupoSancionado,
      String hora,
      String fecha,
      String nombreProfesor) async {
    bool existe = true;
    bool existeT;
    String des = '';
    if (numeroParte == null) {
      existe = false;
      numeroParte = await obtenerNumParte();
    }

    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');
    //Insert en la tabla parte
    if (existe == false) {
      await connection.execute(
          "INSERT INTO parte (numparte,nom_sancionado,grupo_sancionado,nombre_profesor,hora,fecha,finalizado,descripcion) VALUES('$numeroParte','$nombreSancionado','$grupoSancionado','$nombreProfesor','$hora','$fecha',false,'$des')");
    } else {
      await connection.execute(
          "UPDATE parte SET nom_sancionado = '$nombreSancionado',grupo_sancionado = '$grupoSancionado',nombre_profesor = '$nombreProfesor',hora = '$hora',fecha = '$fecha',finalizado = false,descripcion = '$des' WHERE numparte = '$numeroParte'");
    }
    if (existe == false) {
      if (tip1) {
        int numerTipificacion = 1;

        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip2) {
        int numerTipificacion = 2;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip3) {
        int numerTipificacion = 3;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip4) {
        int numerTipificacion = 4;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip5) {
        int numerTipificacion = 5;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip6) {
        int numerTipificacion = 6;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip7) {
        int numerTipificacion = 7;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip8) {
        int numerTipificacion = 8;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip9) {
        int numerTipificacion = 9;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip10) {
        int numerTipificacion = 10;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip11) {
        int numerTipificacion = 11;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip12) {
        int numerTipificacion = 12;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip13) {
        int numerTipificacion = 13;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip14) {
        int numerTipificacion = 14;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip15) {
        int numerTipificacion = 15;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip16) {
        int numerTipificacion = 16;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      String nia = await obtenerNIA(nombreSancionado, grupoSancionado);
      await connection.execute(
          "INSERT INTO docente_parte_alumno (dni,num_parte,nia) VALUES('$dni','$numeroParte','$nia')");
    } else {
      String nia = await obtenerNIA(nombreSancionado, grupoSancionado);
      await connection.execute(
          "UPDATE docente_parte_alumno SET nia = '$nia' WHERE num_parte = '$numeroParte'");

      existeT = await comprobarExistenciaTipificacion(numeroParte, 1);

      if (existeT == false) {
        if (tip1) {
          int numerTipificacion = 1;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip1 == false) {
          int numerTipificacion = 1;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 2);
      if (existeT == false) {
        if (tip2) {
          int numerTipificacion = 2;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip2 == false) {
          int numerTipificacion = 2;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 3);
      if (existeT == false) {
        if (tip3) {
          int numerTipificacion = 3;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip3 == false) {
          int numerTipificacion = 3;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 4);
      if (existeT == false) {
        if (tip4) {
          int numerTipificacion = 4;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip4 == false) {
          int numerTipificacion = 4;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 5);
      if (existeT == false) {
        if (tip5) {
          int numerTipificacion = 5;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip5 == false) {
          int numerTipificacion = 5;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 6);
      if (existeT == false) {
        if (tip6) {
          int numerTipificacion = 6;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip6 == false) {
          int numerTipificacion = 6;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 7);
      if (existeT == false) {
        if (tip7) {
          int numerTipificacion = 7;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip7 == false) {
          int numerTipificacion = 7;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 8);
      if (existeT == false) {
        if (tip8) {
          int numerTipificacion = 8;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip8 == false) {
          int numerTipificacion = 8;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 9);
      if (existeT == false) {
        if (tip9) {
          int numerTipificacion = 9;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip9 == false) {
          int numerTipificacion = 9;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }

      existeT = await comprobarExistenciaTipificacion(numeroParte, 10);
      if (existeT == false) {
        if (tip10) {
          int numerTipificacion = 10;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip10 == false) {
          int numerTipificacion = 10;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 11);
      if (existeT == false) {
        if (tip11) {
          int numerTipificacion = 11;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip11 == false) {
          int numerTipificacion = 11;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 12);
      if (existeT == false) {
        if (tip12) {
          int numerTipificacion = 12;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip12 == false) {
          int numerTipificacion = 12;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 13);
      if (existeT == false) {
        if (tip13) {
          int numerTipificacion = 13;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip13 == false) {
          int numerTipificacion = 13;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 14);
      if (existeT == false) {
        if (tip14) {
          int numerTipificacion = 14;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip14 == false) {
          int numerTipificacion = 14;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 15);
      if (existeT == false) {
        if (tip15) {
          int numerTipificacion = 15;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip15 == false) {
          int numerTipificacion = 15;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
      existeT = await comprobarExistenciaTipificacion(numeroParte, 16);
      if (existeT == false) {
        if (tip16) {
          int numerTipificacion = 16;
          await connection.execute(
              "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
        }
      } else {
        if (tip16 == false) {
          int numerTipificacion = 16;
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");
        }
      }
    }

    await connection.close();
  }

  /* Future guardarParteP2(
      String descripcion,
      Parte parte,
      bool tip1,
      bool tip2,
      bool tip3,
      bool tip4,
      bool tip5,
      bool tip6,
      bool tip7,
      bool tip8,
      bool tip9,
      bool tip10,
      bool tip11,
      bool tip12,
      bool tip13,
      bool tip14,
      bool tip15,
      bool tip16) async {
    int numeroParte = parte.getNumParte();
    bool existe = false;
    int numerTipificacion;
    List<bool> tipificaciones = [
      tip1,
      tip2,
      tip3,
      tip4,
      tip5,
      tip6,
      tip7,
      tip8,
      tip9,
      tip10,
      tip11,
      tip12,
      tip13,
      tip14,
      tip15,
      tip16
    ];
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    List<List<dynamic>> results = await connection
        .query("SELECT numparte FROM parte WHERE numparte = '$numeroParte'");

    for (final row in results) {
      double a = row[0];
      int numero = a.toInt();

      if (numero == numeroParte) {
        existe = true;
      } else {
        existe = false;
      }
    }

    if (existe) {
      connection.execute(
          "UPDATE parte SET descripcion = '$descripcion', pag = 'P2' WHERE numparte = '$numeroParte'");
      numerTipificacion = 1;
    tipificaciones.forEach((tip) async {
        var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
            username: "postgres", password: "postgres");
        await connection.open();
        existe = await comprobarExistencia(numeroParte, numerTipificacion);
        if (tip == false) {
          if (existe) {
            await connection.execute(
                "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
          }
        } else {
          if (existe == false) {
            await connection.execute(
                "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
          }
        }
      });
      /* if (!tip1) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 2;
      if (!tip2) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 3;
      if (!tip3) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 4;
      if (!tip4) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 5;
      if (!tip5) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 6;
      if (!tip6) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 7;
      if (!tip7) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 8;
      if (!tip8) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 9;
      if (!tip9) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 10;
      if (!tip10) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 11;
      if (!tip11) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 12;
      if (!tip12) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 13;
      if (!tip13) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }

      numerTipificacion = 14;
      existe = await comprobarExistencia(numeroParte, numerTipificacion);
      if (tip14 == false) {
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        if (existe == false) {
          await connection.execute(
              "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
        }
      }

      numerTipificacion = 15;
      if (!tip15) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      }
      numerTipificacion = 16;
      if (!tip16) {
        List<List<dynamic>> results = await connection.query(
            "SELECT num_parte,num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion'");

        for (final row in results) {
          double a = row[0];
          double b = row[1];

          int a2 = a.toInt();
          int b2 = b.toInt();

          if (a2 == numeroParte && b2 == numerTipificacion) {
            existe = true;
          } else {
            existe = false;
          }
        }
        if (existe) {
          await connection.execute(
              "DELETE FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numerTipificacion' ");
        }
      } else {
        await connection.execute(
            "INSERT INTO parte_tipificacion(num_parte,num_tipificacion) VALUES($numeroParte,$numerTipificacion) ");
      } */
    } else {
      String nia;
      String dni;
      String nombreSancionado = parte.getNombreSancionado();
      String grupoSancioando = parte.getGrupoSancioando();
      String nombreProfesor = parte.getNombreProfesor();
      String fecha = parte.getFecha();
      String hora = parte.getHora();
      await connection.execute(
          "INSERT INTO parte (numparte,nom_sancionado,grupo_sancionado,nombre_profesor,descripcion,hora,fecha,finalizado,pag) VALUES('$numeroParte','$nombreSancionado','$grupoSancioando','$nombreProfesor','$descripcion','$hora','$fecha',false,'P2')");
      if (tip1) {
        int numerTipificacion = 1;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip2) {
        int numerTipificacion = 2;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip3) {
        int numerTipificacion = 3;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip4) {
        int numerTipificacion = 4;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip5) {
        int numerTipificacion = 5;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip6) {
        int numerTipificacion = 6;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip7) {
        int numerTipificacion = 7;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip8) {
        int numerTipificacion = 8;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip9) {
        int numerTipificacion = 9;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip10) {
        int numerTipificacion = 10;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip11) {
        int numerTipificacion = 11;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip12) {
        int numerTipificacion = 12;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip13) {
        int numerTipificacion = 13;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip14) {
        int numerTipificacion = 14;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip15) {
        int numerTipificacion = 15;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      if (tip16) {
        int numerTipificacion = 16;
        await connection.execute(
            "INSERT INTO parte_tipificacion (num_parte,num_tipificacion) VALUES('$numeroParte','$numerTipificacion')");
      }
      nia = await obtenerNIA(nombreSancionado);
      dni = await obtenerDNI(nombreProfesor);

      await connection.execute(
          "INSERT INTO docente_parte_alumno (dni,num_parte,nia) VALUES('$dni','$numeroParte','$nia')");
    }
    await connection.close();
  }*/

  Future<bool> comprobarExistenciaParte(int numeroParte) async {
    bool existe = false;
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    List<List<dynamic>> results = await connection
        .query("SELECT numparte FROM parte WHERE numparte = '$numeroParte'");

    for (final row in results) {
      double a = row[0];

      int a2 = a.toInt();

      if (a2 == numeroParte) {
        existe = true;
      } else {
        existe = false;
      }
    }
    await connection.close();
    return existe;
  }

  Future<bool> comprobarExistenciaTipificacion(
      int numeroParte, int numeroTipificacion) async {
    bool existe = false;
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    List<List<dynamic>> results = await connection.query(
        "SELECT num_parte, num_tipificacion FROM parte_tipificacion WHERE num_parte = '$numeroParte' AND num_tipificacion = '$numeroTipificacion'");

    for (final row in results) {
      double a = row[0];
      double b = row[1];

      int a2 = a.toInt();
      int b2 = b.toInt();

      if (a2 == numeroParte && b2 == numeroTipificacion) {
        existe = true;
      } else {
        existe = false;
      }
    }

    await connection.close();
    return existe;
  }

  Future<List<bool>> obtenerTipificaciones(int numeroParte) async {
    int numeroTipificacion = 1;
    int contador = 0;

    bool exi;
    List<bool> tipifiaciones = [];

    while (contador < 16) {
      exi = await comprobarExistenciaTipificacion(
          numeroParte, numeroTipificacion);
      tipifiaciones.add(exi);
      numeroTipificacion++;
      contador++;
    }
    print(tipifiaciones);
    return tipifiaciones;
  }

  Future<int> obtenerNumeroDePartes(String nia) async {
    int numeroPartes;
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    List<List<dynamic>> results = await connection
        .query("SELECT COUNT(*) FROM docente_parte_alumno WHERE nia = '$nia'");

    for (final row in results) {
      int a = row[0];
      numeroPartes = a;
    }

    await connection.close();
    return numeroPartes;
  }

  Future<String> obtenerClaseT(String dni) async {
    String claseT;
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    List<List<dynamic>> results = await connection
        .query("SELECT clase_t from docente WHERE dni = '$dni'");

    for (final row in results) {
      String a = row[0];
      claseT = a;
    }

    await connection.close();
    return claseT;
  }

  Future<int> obtenerAlertas(String dni) async {
    int alerta;
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    List<List<dynamic>> results = await connection
        .query("SELECT alertas from docente WHERE dni = '$dni'");

    for (final row in results) {
      int a = row[0].toInt();
      alerta = a;
    }

    await connection.close();
    return alerta;
  }

  Future<String> obtenerEmail(String nia) async {
    String mail;
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    List<List<dynamic>> results =
        await connection.query("SELECT email from alumno WHERE nia = '$nia'");

    for (final row in results) {
      String a = row[0];
      mail = a;
    }

    await connection.close();
    return mail;
  }

  /* Future<int> obtenerRol(String dni) async {
    int alerta;
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    List<List<dynamic>> results = await connection
        .query("SELECT alertas from docente WHERE dni = '$dni'");

    for (final row in results) {
      int a = row[0].toInt();
      alerta = a;
    }

    await connection.close();
    return alerta;
  } */

  Future resetAlertas(String dni) async {
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();
    await connection
        .execute("UPDATE docente SET alertas = 0 WHERE dni = '$dni'");

    await connection.close();
  }

  Future borrarParte(int numParte) async {
    var connection = PostgreSQLConnection(ip, 5432, "BD_Gestor_Partes",
        username: "postgres", password: "postgres");
    await connection.open();

    print('Conectandose a la base de datos....');

    await connection.execute("DELETE FROM parte WHERE numparte = '$numParte'");
    await connection.close();
  }
}
