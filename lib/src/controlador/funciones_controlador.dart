import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Controlador {
  Controlador();

  /*
  Función vieja de loggin que no se conecta a la base de datos

   void loggin(BuildContext context, String nombre, int code, String passw) {
    if (nombre == 'Alejandro' && code == passw.hashCode) {
      Navigator.pushNamed(context, '/PaginaPruebas');
    } else if (nombre == null || code == null) {
      final snackBar = SnackBar(
        content: Text('Hay datos sin introducir'),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Error al introducir los datos'),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } */

  //Función de loggin que se conecta a la base de datos y busca si
  // existe el usuario al que se le han insertado los datos
  Future loginDatabase(BuildContext context, String dni, String nombre) async {
    bool acceso = false;

    //Conexion a la base de datos postgres
    var connection = PostgreSQLConnection('192.168.1.97', 5432, "prueba",
        username: "postgres", password: "postgres");
    await connection.open();
    print('Conectandose a la base de datos....');

    //Busqueda de los datos
    List<List<dynamic>> results =
        await connection.query("SELECT dni,nombre FROM tabla_prueba");

    //Bucle que recorre los datos de las columnas obtenidas
    for (final row in results) {
      //Primera columna
      var a = row[0];
      //Segunda columna
      var b = row[1];

      //Check de los datos
      if (dni == a && nombre == b) acceso = true;
    }

    //Casos de acción segun el resultado true fals o nulls
    if (acceso) {
      Navigator.pushNamed(context, '/PaginaPruebas');
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

    var connection = PostgreSQLConnection('192.168.1.97', 5432, "prueba",
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

    var connection = PostgreSQLConnection('192.168.1.97', 5432, "prueba",
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

  Future obtenerUsuarios() async {
    //Función que se conecta a la base de dtaos, recoge todos los usuarios
    //y lo almacena en un array de Map<String,dynamic>
    //de esta forma podemos acceder a todos los usuarios y datos desde la
    //aplicación.
    //Con esto podremos crear tantos wisgets como usuarios queramos

    //Creamos las variables de array y Map
    List<Map<String, dynamic>> usuarios = [];
    Map<String, dynamic> usuariosbd;

    //Nos conectamos a la base de datos
    var connection = PostgreSQLConnection('192.168.1.97', 5432, "prueba",
        username: "postgres", password: "postgres");
    await connection.open();
    print('Conectandose a la base de datos....');

    //Obtenemos el dni,nombre, y edad de todos los usuarios de la base de datos
    //y los almacenamos en el Map que a su vez se introduce en el array de Maps
    List<List<dynamic>> results =
        await connection.query("SELECT dni,nombre,edad FROM tabla_prueba");

    for (final row in results) {
      String a = row[0];
      String b = row[1];
      double c = row[2];

      usuariosbd = {"dni": a, "nombre": b, "edad": c};

      usuarios.add(usuariosbd);
    }

    //Ahora podemos recorrer el array, y cada iteración es un map con dni,nombre, y edad
    for (int x = 0; x < usuarios.length; x++) {
      //Creamos un Map donde guardar las iteraciones de Maps
      //Y ya podemos usar los datos guardados en los Maps
      Map<String, dynamic> prueba = usuarios[x];
      print('DNI:' + prueba["dni"]);
      print('Nombre:' + prueba["nombre"]);
      double edad = prueba["edad"];
      print('Edad: $edad');
    }
    await connection.close();
    print('Conexion finalizada');
  }

  void mostrarDatos(String object) {
    print(object);
  }
}
