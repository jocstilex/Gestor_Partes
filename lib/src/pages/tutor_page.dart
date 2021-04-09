import 'package:flutter/material.dart';
import 'package:gestor_partes/src/widgets/botones_widgets.dart';

class TutorPage extends StatefulWidget {
  @override
  _TutorPageState createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  BotonesWidgets w = BotonesWidgets();
  int _num = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutor_Page'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            w.btnCrearParte(context),
            w.btnBuscarAlumno(context),
            _boton('Ver Clase'),
            w.btnSalir(),
          ],
        ),
      ),
      floatingActionButton: _alerts(),
    );
  }

  Widget _boton(String texto) {
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
              onPressed: () {},
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

  Widget _alerts() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
                color: Colors.blue[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70.0)),
                elevation: 30.0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 50.0, left: 20.0),
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          '$_num',
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        )),
                    Container(
                      padding: EdgeInsets.only(right: 10.0),
                      child: FloatingActionButton(
                        backgroundColor: Colors.blue[300],
                        elevation: 0,
                        onPressed: () {
                          setState(() {
                            _num++;
                          });
                        },
                        child:
                            Icon(Icons.add_alert_outlined, color: Colors.white),
                        //textColor: Colors.white,
                        // color: Colors.red[700],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ],
    );
  }
}
