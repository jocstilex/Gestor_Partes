import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/controlador/utiles_controlador.dart';
//import 'package:gestor_partes/src/pages/pages_utilities/pages_utiles_GBD/bdUpdateDocente_utiles_page.dart';

// ignore: must_be_immutable
class UpdatePageAlumnos extends StatefulWidget {
  List<String> _nias = [];

  TextEditingController nomAlum = TextEditingController();
  TextEditingController apeAlumno = TextEditingController();
  TextEditingController curAlumno = TextEditingController();
  TextEditingController niaAlumno = TextEditingController();

  UpdatePageAlumnos(
      this._nias, this.nomAlum, this.apeAlumno, this.curAlumno, this.niaAlumno);
  @override
  _UpdatePageAlumnosState createState() => _UpdatePageAlumnosState();
}

class _UpdatePageAlumnosState extends State<UpdatePageAlumnos> {
  Utiles u = Utiles();
  Controlador c = Controlador();
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
  String _nian;
  String _niav;
  String _name;
  String _subname;
  String _curs;
  int i = 0;
  // List<String> listas = ['1ESO', '2ESO', '3ESO', '4ESO'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        crearDropDownAlumno('NIAs:', widget._nias),
        _inputNIA(),
        _inputName(),
        _inputSubName(),
        _mostrarCurso(),
        _crearDropdownCurso(),
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
                  c.modificarAlumno(
                      context, _nian, _niav, _name, _subname, _optSelec);
                  widget._nias.remove(_niav);
                  widget._nias.add(_nian);
                  setState(() {});
                },
                child: Text('Modificar'))),
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
                child: Text('Salir')))
      ]),
    );
  }

  Widget crearDropDownAlumno(String texto, List<String> lista) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 100.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text(
              texto,
              style: u.estilotexto,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 60.0),
            child: DropdownButton(
              value: lista[i],
              items: getOpcionesNiasDropDown(lista),
              onChanged: (opt) async {
                i = 0;
                for (int x = 0; x < widget._nias.length; x++) {
                  if (opt == lista[x]) {
                    i = x;
                  }
                }
                _name = await c.obtenerNombre(lista[i]);
                _subname = await c.obtenerApellido(lista[i]);
                _curs = await c.obtenerCurso(lista[i]);
                widget.niaAlumno.text = lista[i];
                _niav = lista[i];
                widget.nomAlum.text = _name;
                widget.apeAlumno.text = _subname;
                widget.curAlumno.text = _curs;
                _optSelec = _curs;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesNiasDropDown(List<String> listaop) {
    List<DropdownMenuItem<String>> lista = [];

    listaop.forEach((opt) {
      lista.add(DropdownMenuItem(
        child: Text(opt),
        value: opt,
      ));
    });
    return lista;
  }

  Widget _inputName() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 23.0),
            child: Text(
              'Nombre: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              cursorColor: Colors.black,
              controller: widget.nomAlum,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _name = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputSubName() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 12.0),
            child: Text(
              'Apellidos: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              controller: widget.apeAlumno,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _subname = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _mostrarCurso() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 40),
            child: Text(
              'Curso: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              controller: widget.curAlumno,
              enabled: false,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _subname = valor;
                });
              },
            ),
          ),
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

  Widget _crearDropdownCurso() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20.0),
          child: Text(
            'Grupo: ',
            style: u.estilotexto,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40.0),
          child: DropdownButton(
            value: _optSelec,
            items: getOpcionesCursoDropDown(_cursos),
            onChanged: (opt) async {
              _optSelec = opt;
              widget.curAlumno.text = _optSelec;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _inputNIA() {
    //  _nia = widget._nias[0];
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 60.0),
            child: Text(
              'NIA: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              controller: widget.niaAlumno,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _nian = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
