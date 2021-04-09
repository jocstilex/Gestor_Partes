import 'package:flutter/material.dart';

class PartePage2 extends StatefulWidget {
  @override
  _PartePage2State createState() => _PartePage2State();
}

class _PartePage2State extends State<PartePage2> {
  bool tipificacion1 = false,
      tipificacion2 = false,
      tipificacion3 = false,
      tipificacion4 = false,
      tipificacion5 = false,
      tipificacion6 = false,
      tipificacion7 = false,
      tipificacion8 = false,
      tipificacion9 = false,
      tipificacion10 = false,
      tipificacion11 = false,
      tipificacion12 = false,
      tipificacion13 = false,
      tipificacion14 = false,
      tipificacion15 = false,
      tipificacion16 = false,
      visualcheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Partes page 2'),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.blueAccent)),
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
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
              Container(
                  margin: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/.../Parte2');
                      },
                      child: Text('Continuar'))),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Salir')))
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
              value: tipificacion1,
              onChanged: (valor) {
                setState(() {
                  tipificacion1 = valor;
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
              value: tipificacion2,
              onChanged: (valor) {
                setState(() {
                  tipificacion2 = valor;
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
              value: tipificacion3,
              onChanged: (valor) {
                setState(() {
                  tipificacion3 = valor;
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
              value: tipificacion4,
              onChanged: (valor) {
                setState(() {
                  tipificacion4 = valor;
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
              value: tipificacion5,
              onChanged: (valor) {
                setState(() {
                  tipificacion5 = valor;
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
              value: tipificacion6,
              onChanged: (valor) {
                setState(() {
                  tipificacion6 = valor;
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
              value: tipificacion7,
              onChanged: (valor) {
                setState(() {
                  tipificacion7 = valor;
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
              value: tipificacion8,
              onChanged: (valor) {
                setState(() {
                  tipificacion9 = valor;
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
              value: tipificacion9,
              onChanged: (valor) {
                setState(() {
                  tipificacion9 = valor;
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
              value: tipificacion10,
              onChanged: (valor) {
                setState(() {
                  tipificacion10 = valor;
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
              value: tipificacion11,
              onChanged: (valor) {
                setState(() {
                  tipificacion11 = valor;
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
              value: tipificacion12,
              onChanged: (valor) {
                setState(() {
                  tipificacion12 = valor;
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
              value: tipificacion13,
              onChanged: (valor) {
                setState(() {
                  tipificacion13 = valor;
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
              value: tipificacion14,
              onChanged: (valor) {
                setState(() {
                  tipificacion14 = valor;
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
              value: tipificacion15,
              onChanged: (valor) {
                setState(() {
                  tipificacion15 = valor;
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
              value: tipificacion16,
              onChanged: (valor) {
                setState(() {
                  tipificacion16 = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
