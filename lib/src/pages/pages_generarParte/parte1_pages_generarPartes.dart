import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/controlador/utiles_controlador.dart';
import 'package:gestor_partes/src/widgets/botones_widgets.dart';

// ignore: must_be_immutable
class PartePage1 extends StatefulWidget {
  List<String> _listaAlumnos = [];
  String _nombreAlumno;
  int numParte;
  String dni;
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
      tipificacion16 = false;
  TextEditingController _nombreDocente;
  TextEditingController _nombreTecAlumno;
  TextEditingController _cursoAlumno;

  PartePage1(
      this.dni,
      this.numParte,
      this._nombreDocente,
      this._listaAlumnos,
      this._nombreAlumno,
      this._nombreTecAlumno,
      this._cursoAlumno,
      this.tipificacion1,
      this.tipificacion2,
      this.tipificacion3,
      this.tipificacion4,
      this.tipificacion5,
      this.tipificacion6,
      this.tipificacion7,
      this.tipificacion8,
      this.tipificacion9,
      this.tipificacion10,
      this.tipificacion11,
      this.tipificacion12,
      this.tipificacion13,
      this.tipificacion14,
      this.tipificacion15,
      this.tipificacion16);

  @override
  _PartePage1State createState() => _PartePage1State();
}

class _PartePage1State extends State<PartePage1> {
  Controlador c = Controlador();
  Utiles u = new Utiles();
  BotonesWidgets btn = BotonesWidgets();
  int i = 0;

  String _fecha = '';
  String _hora = '';
  String _nia;
  //String _nombreDocente = '';
  List<String> h = [''];
  //String _nombreAlumno = '';

  TextEditingController _inputFieldDateController = TextEditingController(
      text: DateTime.now().day.toString() +
          '/' +
          DateTime.now().month.toString() +
          '/' +
          DateTime.now().year.toString());

  TextEditingController _inputFieldHourController = TextEditingController(
      text: TimeOfDay.now().hour.toString() +
          ':' +
          TimeOfDay.now().minute.toString());

  List<String> _cursos = [
    '1ESO',
    '2ESO',
    '3ESO',
    '4ESO',
    '1BAC',
    '2BAC',
    '1GM',
    '2GM'
  ];
  String _optSelec = '1ESO';

  //final ValueChanged<TimeOfDay> selectTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión partes 1'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          crearInputPersonas(),
          _inputNameAlumno(),
          _inputCursoAl(),
          _inputName(),
          _crearFecha(context),
          _crearHora(context),
          Text('Opciones de parte rápido'),
          _crearCheckBox1(),
          _crearCheckBox2(),
          _crearCheckBox3(),
          _crearCheckBox4(),
          _crearCheckBox5(),
          _crearCheckBox6(),
          _crearCheckBox7(),
          _crearCheckBox8(),
          _crearCheckBox9(),
          _crearCheckBox10(),
          _crearCheckBox11(),
          _crearCheckBox12(),
          _crearCheckBox13(),
          _crearCheckBox14(),
          _crearCheckBox15(),
          _crearCheckBox16(),
          btn.btnCrearParte2(
              context,
              widget.dni,
              widget.numParte,
              widget.tipificacion1,
              widget.tipificacion2,
              widget.tipificacion3,
              widget.tipificacion4,
              widget.tipificacion5,
              widget.tipificacion6,
              widget.tipificacion7,
              widget.tipificacion8,
              widget.tipificacion9,
              widget.tipificacion10,
              widget.tipificacion11,
              widget.tipificacion12,
              widget.tipificacion13,
              widget.tipificacion14,
              widget.tipificacion15,
              widget.tipificacion16,
              widget._nombreAlumno,
              widget._cursoAlumno.text,
              _inputFieldHourController.text,
              _inputFieldDateController.text,
              widget._nombreDocente.text),
          btn.btnguardarP1(
              widget.numParte,
              context,
              widget._cursoAlumno.text,
              widget.dni,
              widget.tipificacion1,
              widget.tipificacion2,
              widget.tipificacion3,
              widget.tipificacion4,
              widget.tipificacion5,
              widget.tipificacion6,
              widget.tipificacion7,
              widget.tipificacion8,
              widget.tipificacion9,
              widget.tipificacion10,
              widget.tipificacion11,
              widget.tipificacion12,
              widget.tipificacion13,
              widget.tipificacion14,
              widget.tipificacion15,
              widget.tipificacion16,
              widget._nombreAlumno,
              _optSelec,
              _inputFieldHourController.text,
              _inputFieldDateController.text,
              widget._nombreDocente.text),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        StadiumBorder()),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      final Color color = states.contains(MaterialState.pressed)
                          ? Colors.blue[200]
                          : Colors.blue[500];
                      return color;
                    }),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Salir'))),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesCursoDropDown(
      List<String> listaop) {
    List<DropdownMenuItem<String>> lista = [];

    listaop.forEach((opt) {
      lista.add(DropdownMenuItem(
        child: Text(opt),
        value: opt,
      ));
    });
    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionesAlumnoDropDown(
      List<String> listaop) {
    List<DropdownMenuItem<String>> lista = [];

    listaop.forEach((opt) {
      lista.add(DropdownMenuItem(
        child: Text(opt),
        value: opt,
      ));
    });
    return lista;
  }

  Widget crearInputPersonas() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blueAccent)),
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: Column(
            children: [
              crearDropdownCurso(),
              crearDropDownAlumno(),
            ],
          ),
        ),
      ),
    );
  }

  Widget crearDropdownCurso() {
    return Row(
      children: [
        Text(
          'Grupo: ',
          style: u.estilotexto,
        ),
        DropdownButton(
          value: _optSelec,
          items: getOpcionesCursoDropDown(_cursos),
          /*  onTap: () {
              await Future.delayed(const Duration(seconds: 1), () {});

            h = await c.listaAlumnos(_optSelec);
            setState(() {}); 
          }, */
          onChanged: (opt) async {
            _optSelec = opt;
            setState(() {});
            if (_optSelec == opt) {
              widget._listaAlumnos = await c.listaAlumnos(_optSelec);
              widget._nombreAlumno = widget._listaAlumnos[0];
              widget._nombreTecAlumno.text = widget._nombreAlumno;
              widget._cursoAlumno.text = _optSelec;
              i = 0;
            }
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget crearDropDownAlumno() {
    return Container(
      child: Row(
        children: [
          Text(
            'Alumno: ',
            style: u.estilotexto,
          ),
          DropdownButton(
            value: widget._listaAlumnos[i],
            items: getOpcionesAlumnoDropDown(widget._listaAlumnos),
            onChanged: (opt) {
              i = 0;
              for (int x = 0; x < widget._listaAlumnos.length; x++) {
                if (opt == widget._listaAlumnos[x]) {
                  i = x;
                  widget._nombreAlumno = opt;
                  widget._nombreTecAlumno.text = opt;
                }
              }
              setState(() {});
            },
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
              'Docente: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              textCapitalization: TextCapitalization.words,
              cursorColor: Colors.black,
              controller: widget._nombreDocente,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  widget._nombreDocente.text = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputCursoAl() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 30.0),
            child: Text(
              'Curso: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              enabled: false,
              textCapitalization: TextCapitalization.words,
              cursorColor: Colors.black,
              controller: widget._cursoAlumno,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputNameAlumno() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 20.0),
            child: Text(
              'Alumno:',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              enabled: false,
              textCapitalization: TextCapitalization.words,
              cursorColor: Colors.black,
              controller: widget._nombreTecAlumno,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  widget._nombreAlumno = valor;
                  widget._nombreTecAlumno.text = widget._nombreAlumno;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearFecha(BuildContext context) {
    //_inputFieldDateController = c.obterFechaActual();
    // _inputFieldDateController = TextEditingController(text: _fecha);
    //modificarController('hola');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 30.0),
            child: Text(
              'Fecha: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextFormField(
              enableInteractiveSelection: false,
              controller: _inputFieldDateController,
              decoration: InputDecoration(
                  //focusColor: Colors.green,
                  /* hintText: 'Fecha de nacimiento',
                  labelText: 'Fecha de nacimiento', */
                  suffixIcon: Icon(Icons.calendar_today_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectDate(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2031),

        //locale: Locale('es', 'ES'),
        locale: Locale('en', 'US'));

    if (picked != null) {
      var formate1 = "${picked.day}/${picked.month}/${picked.year}";
      _fecha = formate1.toString();
      _inputFieldDateController.text = _fecha;
    }
  }

  Widget _crearHora(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 30.0),
            child: Text(
              'Hora:   ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              enableInteractiveSelection: false,
              controller: _inputFieldHourController,
              decoration: InputDecoration(
                  //focusColor: Colors.green,
                  /* hintText: 'Fecha de nacimiento',
                  labelText: 'Fecha de nacimiento', */
                  suffixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectHour(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  _selectHour(BuildContext context) async {
    TimeOfDay picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (picked != null) {
      setState(() {
        var formate1 = "${picked.hour}:${picked.minute}";
        _hora = formate1.toString();
        _inputFieldHourController.text = _hora;
      });
    }
  }

  Widget _crearCheckBox1() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 5.0),
          child: Text(
            'Puntualidad',
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 105),
            child: Checkbox(
              value: widget.tipificacion1,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion1 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox2() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0), child: Text('Abandonar aula')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 80),
            child: Checkbox(
              value: widget.tipificacion3,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion3 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox3() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Text('Injurias y ofensas')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 70),
            child: Checkbox(
              value: widget.tipificacion5,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion5 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox4() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0), child: Text('Boicotear clase')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 85),
            child: Checkbox(
              value: widget.tipificacion7,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion7 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox5() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Text('Robo o deterioramiento')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 35),
            child: Checkbox(
              value: widget.tipificacion9,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion9 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox6() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0), child: Text('No asistencia')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 95),
            child: Checkbox(
              value: widget.tipificacion11,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion11 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox7() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 5.0),
          child: Text('Agresion'),
        ), //44
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 125),
            child: Checkbox(
              value: widget.tipificacion13,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion13 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox8() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Text('No trae el material')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 67),
            child: Checkbox(
              value: widget.tipificacion15,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion15 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox9() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Text('Cafetria fuera de horario')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 30),
            child: Checkbox(
              value: widget.tipificacion2,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion2 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox10() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Text('Uso inadecuado de las TIC')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 15),
            child: Checkbox(
              value: widget.tipificacion4,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion4 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox11() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0), child: Text('Uso del móvil')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 98),
            child: Checkbox(
              value: widget.tipificacion6,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion6 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox12() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Text('No informa a la familia')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 40),
            child: Checkbox(
              value: widget.tipificacion8,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion8 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox13() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0), child: Text('Desobediencia')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 90),
            child: Checkbox(
              value: widget.tipificacion10,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion10 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox14() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 5.0),
          child: Text(
            'Incumplimiento de las\nmedidas',
            style: TextStyle(fontSize: 13.5),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 50),
            child: Checkbox(
              value: widget.tipificacion12,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion12 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox15() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Text('Molesta en clase')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 80),
            child: Checkbox(
              value: widget.tipificacion14,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion14 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCheckBox16() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: 5.0), child: Text('Comer en clase')),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 90),
            child: Checkbox(
              value: widget.tipificacion16,
              onChanged: (valor) {
                setState(() {
                  widget.tipificacion16 = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  /*  Widget _textArea() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: TextField(
        maxLines: 7,
        decoration: InputDecoration(
            labelText: 'Descripción de la incidencia',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      ),
    );
  } */
}
