import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/parte.dart';
import 'package:gestor_partes/src/widgets/botones_widgets.dart';

// ignore: must_be_immutable
class PartePage2 extends StatefulWidget {
  Parte parte = Parte();
  String dni;

  bool tip1 = false,
      tip2 = false,
      tip3 = false,
      tip4 = false,
      tip5 = false,
      tip6 = false,
      tip7 = false,
      tip8 = false,
      tip9 = false,
      tip10 = false,
      tip11 = false,
      tip12 = false,
      tip13 = false,
      tip14 = false,
      tip15 = false,
      tip16 = false;
  PartePage2(
      this.dni,
      this.parte,
      this.tip1,
      this.tip2,
      this.tip3,
      this.tip4,
      this.tip5,
      this.tip6,
      this.tip7,
      this.tip8,
      this.tip9,
      this.tip10,
      this.tip11,
      this.tip12,
      this.tip13,
      this.tip14,
      this.tip15,
      this.tip16);
  @override
  _PartePage2State createState() => _PartePage2State();
}

class _PartePage2State extends State<PartePage2> {
  BotonesWidgets btn = BotonesWidgets();
  String _descripcion = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gestión partes 2'),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.blueAccent)),
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: ListView(
//            physics: const NeverScrollableScrollPhysics(),
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [_crearCheckBox1(), _crearCheckBox2()],
                ),
              ),
              Row(
                children: [_crearCheckBox3(), _crearCheckBox4()],
              ),
              Row(
                children: [_crearCheckBox5(), _crearCheckBox6()],
              ),
              Row(
                children: [_crearCheckBox7(), _crearCheckBox8()],
              ),
              Row(
                children: [_crearCheckBox9(), _crearCheckBox10()],
              ),
              Row(
                children: [_crearCheckBox11(), _crearCheckBox12()],
              ),
              Row(
                children: [_crearCheckBox13(), _crearCheckBox14()],
              ),
              Row(
                children: [_crearCheckBox15(), _crearCheckBox16()],
              ),
              _textArea(),
              btn.btnCrearParte3(
                  context,
                  widget.dni,
                  _descripcion,
                  widget.parte,
                  widget.tip1,
                  widget.tip2,
                  widget.tip3,
                  widget.tip4,
                  widget.tip5,
                  widget.tip6,
                  widget.tip7,
                  widget.tip8,
                  widget.tip9,
                  widget.tip10,
                  widget.tip11,
                  widget.tip12,
                  widget.tip13,
                  widget.tip14,
                  widget.tip15,
                  widget.tip16),
              /* btn.btnguardarP2(
                  context,
                  _descripcion,
                  widget.parte,
                  widget.tip1,
                  widget.tip2,
                  widget.tip3,
                  widget.tip4,
                  widget.tip5,
                  widget.tip6,
                  widget.tip7,
                  widget.tip8,
                  widget.tip9,
                  widget.tip10,
                  widget.tip11,
                  widget.tip12,
                  widget.tip13,
                  widget.tip14,
                  widget.tip15,
                  widget.tip16), */
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            StadiumBorder()),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.pressed)
                                  ? Colors.blue[200]
                                  : Colors.blue[500];
                          return color;
                        }),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text('Salir'))),
              // Text(_descripcion)
            ],
          ),
        ));
  }

  Widget _crearCheckBox1() {
    return Expanded(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Text(
              'Falta reiterada e\ninjustificada de\npuntualidad           ',
            ),
          ),
          Expanded(
            child: Checkbox(
              value: widget.tip1,
              onChanged: (valor) {
                setState(() {
                  widget.tip1 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox2() {
    return Expanded(
      child: Row(
        children: [
          Text('Ir a la cafeteria en\nhorario de clase          '),
          Expanded(
            child: Checkbox(
              value: widget.tip2,
              onChanged: (valor) {
                setState(() {
                  widget.tip2 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox3() {
    return Expanded(
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 5.0),
              child: Text('Salir del aula\nsin permiso           ')),
          Expanded(
            child: Checkbox(
              value: widget.tip3,
              onChanged: (valor) {
                setState(() {
                  widget.tip3 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox4() {
    return Expanded(
      child: Row(
        children: [
          Text('Uso inadecuado\nde las TIC                     '),
          Expanded(
            child: Checkbox(
              value: widget.tip4,
              onChanged: (valor) {
                setState(() {
                  widget.tip4 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox5() {
    return Expanded(
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 5.0),
              child: Text('Injurias y\nofensas                  ')),
          Expanded(
            child: Checkbox(
              value: widget.tip5,
              onChanged: (valor) {
                setState(() {
                  widget.tip5 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox6() {
    return Expanded(
      child: Row(
        children: [
          Text('Uso del móvil u\notros dispositivos       '),
          Expanded(
            child: Checkbox(
              value: widget.tip6,
              onChanged: (valor) {
                setState(() {
                  widget.tip6 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox7() {
    return Expanded(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Text(
                'Alteración del\ndesarrollo normal\nde las clases         '),
          ), //44
          Expanded(
            child: Checkbox(
              value: widget.tip7,
              onChanged: (valor) {
                setState(() {
                  widget.tip7 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox8() {
    return Expanded(
      child: Row(
        children: [
          Text(
              'Negativa a trasladar\ninformación\na la familia                   '),
          Expanded(
            child: Checkbox(
              value: widget.tip8,
              onChanged: (valor) {
                setState(() {
                  widget.tip8 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox9() {
    return Expanded(
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 5.0),
              child: Text('Robo o\ndeterioramiento\nintencionado         ')),
          Expanded(
            child: Checkbox(
              value: widget.tip9,
              onChanged: (valor) {
                setState(() {
                  widget.tip9 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox10() {
    return Expanded(
      child: Row(
        children: [
          Text('Desobediencia\nal profesorado            '),
          Expanded(
            child: Checkbox(
              value: widget.tip10,
              onChanged: (valor) {
                setState(() {
                  widget.tip10 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox11() {
    return Expanded(
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 5.0),
              child: Text('Falta injustificada\nde asistencia         ')),
          Expanded(
            child: Checkbox(
              value: widget.tip11,
              onChanged: (valor) {
                setState(() {
                  widget.tip11 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox12() {
    return Expanded(
      child: Row(
        children: [
          Text('Incumplimiento\nde las medidas\ncorrectivas                  '),
          Expanded(
            child: Checkbox(
              value: widget.tip12,
              onChanged: (valor) {
                setState(() {
                  widget.tip12 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox13() {
    return Expanded(
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 5.0),
              child: Text(
                  'Acciones contra\nla integridad\ny la salud                ')),
          Expanded(
            child: Checkbox(
              value: widget.tip13,
              onChanged: (valor) {
                setState(() {
                  widget.tip13 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox14() {
    return Expanded(
      child: Row(
        children: [
          Text(
            'Molestar o interrumpir\nreiteradamente\nen el aula',
            style: TextStyle(fontSize: 13.5),
          ),
          Expanded(
            child: Checkbox(
              value: widget.tip14,
              onChanged: (valor) {
                setState(() {
                  widget.tip14 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox15() {
    return Expanded(
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 5.0),
              child: Text('Falta sistematica\ndel material            ')),
          Expanded(
            child: Checkbox(
              value: widget.tip15,
              onChanged: (valor) {
                setState(() {
                  widget.tip15 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCheckBox16() {
    return Expanded(
      child: Row(
        children: [
          Text('Comer y beber\nen espacios no\nhabilitados                   '),
          Expanded(
            child: Checkbox(
              value: widget.tip16,
              onChanged: (valor) {
                setState(() {
                  widget.tip16 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _textArea() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: TextField(
        maxLines: 7,
        decoration: InputDecoration(
            labelText: 'Descripción de la incidencia',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        onChanged: (value) {
          setState(() {
            _descripcion = value;
          });
        },
      ),
    );
  }
}
