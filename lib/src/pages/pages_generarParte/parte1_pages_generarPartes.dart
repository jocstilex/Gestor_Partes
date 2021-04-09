import 'package:flutter/material.dart';

class PartePage1 extends StatefulWidget {
  @override
  _PartePage1State createState() => _PartePage1State();
}

class _PartePage1State extends State<PartePage1> {
  TextStyle estilotexto = TextStyle(fontSize: 20.0);

  String _fecha = '';
  String _hora = '';
  String _nombre;

  TextEditingController _inputFieldDateController = TextEditingController();
  TextEditingController _inputFieldHourController = TextEditingController();

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
  List<String> _alumnos = [
    'Pepe',
    'Maria',
    'Alex',
    'Sonia',
    'Alejandro Lahiguera Gonzalez'
  ];
  String _optSelec = '1ESO';
  String _almSelec = 'Pepe';

  //final ValueChanged<TimeOfDay> selectTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generar Parte 1'),
        centerTitle: true,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          /*
            Versión piramide
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [crearInputPersonas()],
          ), */
          crearInputPersonas(),
          _inputName(),
          _crearFecha(context),
          _crearHora(context),
          _textArea(),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
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
          style: estilotexto,
        ),
        DropdownButton(
          value: _optSelec,
          items: getOpcionesCursoDropDown(_cursos),
          onChanged: (opt) {
            setState(() {
              _optSelec = opt;
            });
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
            style: estilotexto,
          ),
          DropdownButton(
            value: _almSelec,
            items: getOpcionesCursoDropDown(_alumnos),
            onChanged: (opt) {
              setState(() {
                _almSelec = opt;
              });
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
              style: estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              textCapitalization: TextCapitalization.words,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() => _nombre = valor);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearFecha(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 30.0),
            child: Text(
              'Fecha: ',
              style: estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
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

  Widget _crearHora(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 30.0),
            child: Text(
              'Hora:   ',
              style: estilotexto,
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

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2031),

        //locale: Locale('es', 'ES'),
        locale: Locale('en', 'US'));

    if (picked != null) {
      setState(() {
        var formate1 = "${picked.day}/${picked.month}/${picked.year}";
        _fecha = formate1.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
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

  Widget _textArea() {
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
  }
}
