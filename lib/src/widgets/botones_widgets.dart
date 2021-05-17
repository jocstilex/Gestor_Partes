import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/controlador/medidaED.dart';
import 'package:gestor_partes/src/controlador/parte.dart';
import 'package:gestor_partes/src/controlador/tipificacion.dart';
import 'package:gestor_partes/src/pages/pages_generarParte/parte1_pages_generarPartes.dart';
import 'package:gestor_partes/src/pages/pages_generarParte/parte2_pages_generarPartes.dart';
import 'package:gestor_partes/src/pages/pages_generarParte/parte3_pages_generarPartes.dart';
import 'package:gestor_partes/src/pages/pages_utilities/borradoresPartes_utiles_page.dart';
import 'package:gestor_partes/src/pages/pages_utilities/estadisticasClase_utiles_page.dart';

class BotonesWidgets {
  Controlador c = Controlador();
  BotonesWidgets();

  Widget btnCrearParte(BuildContext context, String nombreDocente, String dni) {
    List<String> listaAlumnos1eso = ['Fallo de conexión con la base de datos'];
    String primerAlumno;
    TextEditingController nombreDoc =
        TextEditingController(text: nombreDocente);

    return Container(
      //height: 5.0,
      padding: EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.pressed)
                      ? Colors.blue[200]
                      : Colors.blue[500];
                  return color;
                }),
              ),
              onPressed: () async {
                int numParte;
                listaAlumnos1eso = await c.listaAlumnos('1ESO');
                primerAlumno = listaAlumnos1eso[0];
                TextEditingController nombreAL =
                    TextEditingController(text: primerAlumno);
                TextEditingController cursoAL =
                    TextEditingController(text: '1ESO');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return new PartePage1(
                      dni,
                      numParte,
                      nombreDoc,
                      listaAlumnos1eso,
                      primerAlumno,
                      nombreAL,
                      cursoAL,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false);
                }));
              },
              child: Text(
                'Poner Parte',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnCrearParte2(
      BuildContext context,
      String dni,
      int numParte,
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
      String cursoSancionado,
      String hora,
      String fecha,
      String nombreProfesor) {
    return Container(
      //height: 5.0,
      padding: EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.pressed)
                      ? Colors.blue[200]
                      : Colors.blue[500];
                  return color;
                }),
              ),
              onPressed: () async {
                if (nombreProfesor == null || nombreProfesor == '') {
                  final snackBar = SnackBar(
                    content: Text('Introduzca un docente'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  Parte parte = Parte();
                  if (numParte == null) {
                    numParte = await c.obtenerNumParte();
                  }
                  String nia =
                      await c.obtenerNIA(nombreSancionado, cursoSancionado);
                  parte.setNiaAlumno(nia);
                  parte.setNumParte(numParte);
                  parte.setNombreSancionado(nombreSancionado);
                  parte.setGrupoSancioando(cursoSancionado);
                  parte.setFecha(fecha);
                  parte.setHora(hora);
                  parte.setNombreProfesor(nombreProfesor);

                  //Añadir elementos al parte

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return new PartePage2(
                      dni,
                      parte,
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
                      tip16,
                    );
                  }));
                }
              },
              child: Text(
                'Continuar',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnCrearParte3(
    BuildContext context,
    String dni,
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
    bool tip16,
  ) {
    return Container(
        margin: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
        child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.pressed)
                    ? Colors.blue[200]
                    : Colors.blue[500];
                return color;
              }),
            ),
            onPressed: () {
              if (tip1 == false &&
                  tip2 == false &&
                  tip3 == false &&
                  tip4 == false &&
                  tip5 == false &&
                  tip6 == false &&
                  tip7 == false &&
                  tip8 == false &&
                  tip9 == false &&
                  tip10 == false &&
                  tip11 == false &&
                  tip12 == false &&
                  tip13 == false &&
                  tip14 == false &&
                  tip15 == false &&
                  tip16 == false) {
                final snackBar = SnackBar(
                  content: Text(
                      'No se puede continuar sin seleccionar una tipificación'),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (descripcion == null || descripcion == '') {
                final snackBar = SnackBar(
                  content: Text(
                      'No se puede continuar sin una descripción de los hehcos'),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                List<bool> tips = [
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
                int x = 0;
                List<Tipificacion> tipificaciones = [];
                for (var i = 1; i <= 16; i++) {
                  Tipificacion t = Tipificacion();
                  t.setNumeroTipificacion(i);
                  t.setValor(tips[x]);
                  tipificaciones.add(t);
                  x++;
                }
                parte.setDescripcion(descripcion);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return new Partepage3(dni, tipificaciones, parte);
                }));
              }
            },
            child: Text('Continuar')));
  }

  Widget btnInsertarParte(
    BuildContext context,
    String dni,
    Parte parte,
    String comTel,
    String fechaComTel,
    List<Tipificacion> listaTipificaciones,
    bool med1,
    bool med2,
    bool med3,
    bool med4,
    bool med5,
    bool med6,
    bool med7,
    bool med8,
    String fechaini2,
    String fechafin2,
    String fechaini3,
    String fechafin3,
    String fechaini4,
    String fechafin4,
    String fechaini5,
    String fechafin5,
    String fechaini6,
    String fechafin6,
    String fechaini7,
    String fechafin7,
    String fechaini8,
    String fechafin8,
  ) {
/*    
De momento no es necesario. Revisar en depuración
 List<bool> med = [
      med1,
      med2,
      med3,
      med4,
      med5,
      med6,
      med7,
      med8,
    ];
    List<String> fechas = [
      fechaini2,
      fechafin2,
      fechaini3,
      fechafin3,
      fechaini4,
      fechafin4,
      fechaini5,
      fechafin5,
      fechaini6,
      fechafin6,
      fechaini7,
      fechafin7,
      fechaini8,
      fechafin8
    ]; */
    return Container(
        margin: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
        child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.pressed)
                    ? Colors.blue[200]
                    : Colors.blue[500];
                return color;
              }),
            ),
            onPressed: () {
              if (med1 == false &&
                  med2 == false &&
                  med3 == false &&
                  med4 == false &&
                  med5 == false &&
                  med6 == false &&
                  med7 == false &&
                  med8 == false) {
                final snackBar = SnackBar(
                  content: Text(
                      'No se puede continuar sin seleccionar una medida educativa'),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } /* 
                Comprobar por que da fallos esta sección del código
                 
               else if (med2 == true) {
                if (fechaini2 == null || fechafin2 == null) {
                  final snackBar = SnackBar(
                    content: Text(
                        'Introduce una fecha de inicio y fin en la medida educativa 2'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } else if (med3 == true) {
                if (fechaini3 == null || fechafin3 == null) {
                  final snackBar = SnackBar(
                    content: Text(
                        'Introduce una fecha de inicio y fin en la medida educativa 3'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } else if (med4 == true) {
                if (fechaini4 == null || fechafin4 == null) {
                  final snackBar = SnackBar(
                    content: Text(
                        'Introduce una fecha de inicio y fin en la medida educativa 4'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } else if (med5 == true) {
                if (fechaini5 == null || fechafin5 == null) {
                  final snackBar = SnackBar(
                    content: Text(
                        'Introduce una fecha de inicio y fin en la medida educativa 5'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } else if (med6 == true) {
                if (fechaini6 == null || fechafin6 == null) {
                  final snackBar = SnackBar(
                    content: Text(
                        'Introduce una fecha de inicio y fin en la medida educativa 6'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } else if (med7 == true) {
                if (fechaini7 == null || fechafin7 == null) {
                  final snackBar = SnackBar(
                    content: Text(
                        'Introduce una fecha de inicio y fin en la medida educativa 7'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } else if (med8 == true) {
                if (fechaini8 == null || fechafin8 == null) {
                  final snackBar = SnackBar(
                    content: Text(
                        'Introduce una fecha de inicio y fin en la medida educativa 8'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } */
              else {
                List<MedidaED> medidasED = [];
                MedidaED m1 = MedidaED();
                m1.setNumeroMedidaED(1);
                m1.setValor(med1);

                MedidaED m2 = MedidaED();
                m2.setNumeroMedidaED(2);
                m2.setValor(med2);
                if (m2.getValor()) {
                  m2.setFechaInicio(fechaini2);
                  m2.setFechaFinal(fechafin2);
                }

                MedidaED m3 = MedidaED();
                m3.setNumeroMedidaED(3);
                m3.setValor(med3);
                if (m3.getValor()) {
                  m3.setFechaInicio(fechaini3);
                  m3.setFechaFinal(fechafin3);
                }

                MedidaED m4 = MedidaED();
                m4.setNumeroMedidaED(4);
                m4.setValor(med4);
                if (m4.getValor()) {
                  m4.setFechaInicio(fechaini4);
                  m4.setFechaFinal(fechafin4);
                }

                MedidaED m5 = MedidaED();
                m5.setNumeroMedidaED(5);
                m5.setValor(med5);
                if (m5.getValor()) {
                  m5.setFechaInicio(fechaini5);
                  m5.setFechaFinal(fechafin5);
                }

                MedidaED m6 = MedidaED();
                m6.setNumeroMedidaED(6);
                m6.setValor(med6);
                if (m6.getValor()) {
                  m6.setFechaInicio(fechaini6);
                  m6.setFechaFinal(fechafin6);
                }

                MedidaED m7 = MedidaED();
                m7.setNumeroMedidaED(7);
                m7.setValor(med7);
                if (m7.getValor()) {
                  m7.setFechaInicio(fechaini7);
                  m7.setFechaFinal(fechafin7);
                }

                MedidaED m8 = MedidaED();
                m8.setNumeroMedidaED(8);
                m8.setValor(med8);
                if (m8.getValor()) {
                  m8.setFechaInicio(fechaini8);
                  m8.setFechaFinal(fechafin8);
                }
                medidasED.add(m1);
                medidasED.add(m2);
                medidasED.add(m3);
                medidasED.add(m4);
                medidasED.add(m5);
                medidasED.add(m6);
                medidasED.add(m7);
                medidasED.add(m8);

                parte.setObservacionComTel(comTel);
                parte.setFechaComTel(fechaComTel);

                c.insertarParte(dni, parte, listaTipificaciones, medidasED);

                _mostrarAlertaParteFinalizado(context, parte);
              }

              //Revisar para depurara
              /*  for (var i = 1; i < 8; i++) {
                MedidaED m = MedidaED();
                m.setNumeroMedidaED(i.toString());
                m.setValor(med[x]);
                while (y < 15) {
                  m.setFechaInicio(fechas[y]);
                  m.setFechaFinal(fechas[y + 1]);
                  y = y + 2;
                }
                medidasED.add(m);
                x++;
              } */
            },
            child: Text('Guardar Parte')));
  }

  Widget btnSalir() {
    return Container(
      //height: 5.0,
      padding: EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.pressed)
                      ? Colors.blue[200]
                      : Colors.blue[500];
                  return color;
                }),
              ),
              onPressed: () {
                exit(0);
              },
              child: Text(
                'Salir',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnBuscarAlumno(BuildContext context) {
    return Container(
      //height: 5.0,
      padding: EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.pressed)
                      ? Colors.blue[200]
                      : Colors.blue[500];
                  return color;
                }),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/.../BuscarAlumno');
              },
              child: Text(
                'Confirmar Alumno',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnComprobarExistenciaAlumno(
      BuildContext context, String nombre, String apellidos) {
    return Container(
      //height: 5.0,
      padding: EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.pressed)
                      ? Colors.blue[200]
                      : Colors.blue[500];
                  return color;
                }),
              ),
              onPressed: () {
                c.buscarAlumno(context, nombre, apellidos);
              },
              child: Text(
                'Buscar Alumno',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnBorradores(
      BuildContext context, String nombreProfesor, String dni) {
    return Container(
      //height: 5.0,
      padding: EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.pressed)
                      ? Colors.blue[200]
                      : Colors.blue[500];
                  return color;
                }),
              ),
              onPressed: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return new BorradoresPartes(nombreProfesor, dni);
                }));
              },
              child: Text(
                'Borradores Partes',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnguardarP1(
      int numParte,
      BuildContext context,
      String nia,
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
      String cursoSancionado,
      String hora,
      String fecha,
      String nombreProfesor) {
    return Container(
      //height: 5.0,
      padding: EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.pressed)
                      ? Colors.blue[200]
                      : Colors.blue[500];
                  return color;
                }),
              ),
              onPressed: () {
                c.guardarParteP1(
                    numParte,
                    dni,
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
                    tip16,
                    nombreSancionado,
                    cursoSancionado,
                    hora,
                    fecha,
                    nombreProfesor);
                _mostrarAlerta(context);
              },
              child: Text(
                'Guardar',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Parte Guardado'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //  Text('El parte se ha guardado.\nDesea continuar.'),
                Image(image: AssetImage('assets/img/check-verde.png'))
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Continuar')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('Salir')),
            ],
          );
        });
  }

  void _mostrarAlertaParteFinalizado(BuildContext context, Parte parte) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Parte Guardado, y finalizado'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //  Text('El parte se ha guardado.\nDesea continuar.'),
                Image(image: AssetImage('assets/img/check-verde.png'))
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('Aceptar')),
              ElevatedButton(
                  onPressed: () {
                    send(parte);
                  },
                  child: Text('Mandar mail')),
            ],
          );
        });
  }

  Future<void> send(Parte parte) async {
    String nia = parte.getNia();
    String recipients = await c.obtenerEmail(nia);
    String alumno = parte.getNombreSancionado();
    String fecha = parte.getFecha();
    String hora = parte.getHora();
    String docente = parte.getNombreProfesor();
    final Email email = Email(
      body:
          'El alumno $alumno ha sido sancionado el $fecha a las $hora por el docente $docente',
      subject: 'Sanción disciplinaria',
      recipients: [recipients],
    );
    await FlutterEmailSender.send(email);
  }

  void mostrarAlertaDatosAlumno(
      BuildContext context, String nom, String ape, int numeroPartes) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Datos de ' + nom + ' ' + ape),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Numero de partes ' + numeroPartes.toString()),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Aceptar')),
            ],
          );
        });
  }

  /*  Widget btnguardarP2(
      BuildContext context,
      String _descripcion,
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
      bool tip16) {
    return Container(
      //height: 5.0,
      padding: EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.pressed)
                      ? Colors.blue[200]
                      : Colors.blue[500];
                  return color;
                }),
              ),
              onPressed: () async {
                c.guardarParteP2(
                    _descripcion,
                    parte,
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
                    tip16);
              },
              child: Text(
                'Guardar',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnguardarP3(BuildContext context) {
    return Container(
      //height: 5.0,
      padding: EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.pressed)
                      ? Colors.blue[200]
                      : Colors.blue[500];
                  return color;
                }),
              ),
              onPressed: () async {},
              child: Text(
                'Guardar',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  } */
  Widget botonEstadisticasClase(
      BuildContext context, String texto, String cursoT) {
    return Container(
      //height: 5.0,
      padding: EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.pressed)
                      ? Colors.blue[200]
                      : Colors.blue[500];
                  return color;
                }),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return new EstadistciasClase(cursoT);
                }));
              },
              child: Text(
                texto,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
