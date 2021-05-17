import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/funciones_controlador.dart';
import 'package:gestor_partes/src/controlador/utiles_controlador.dart';

// ignore: must_be_immutable
class UpdatePageDocentes extends StatefulWidget {
  List<String> _dnis = [];
  bool tutor = false;
  bool profesor = false;
  bool jefatura = false;
  bool admin = false;
  TextEditingController _nombreDocente = TextEditingController();
  TextEditingController _apellidoDocente = TextEditingController();
  TextEditingController _rolDocente = TextEditingController();
  TextEditingController _claseTDocente = TextEditingController();
  TextEditingController _dni = TextEditingController();
  UpdatePageDocentes(
      this._dnis,
      this._dni,
      this._nombreDocente,
      this._apellidoDocente,
      this._rolDocente,
      this.tutor,
      this.jefatura,
      this.admin,
      this.profesor);
  @override
  _UpdatePageDocentesState createState() => _UpdatePageDocentesState();
}

class _UpdatePageDocentesState extends State<UpdatePageDocentes> {
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
  String _name, _subname, _rol, _dni, _claseT, _dniv;

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            crearDropDownDocente(),
            _inputName(),
            _inputSubName(),
            _inputDNI(),
            _inputRol(),
            _checkRoles(),
            _crearDropdownCurso(),
            _inputTurotia(),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          StadiumBorder()),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        final Color color =
                            states.contains(MaterialState.pressed)
                                ? Colors.blue[200]
                                : Colors.blue[500];
                        return color;
                      }),
                    ),
                    onPressed: () {
                      c.modificarDocente(context, _dni, _dniv, _name, _subname,
                          widget._rolDocente.text, widget._claseTDocente.text);
                      widget._dnis.remove(_dniv);
                      widget._dnis.add(_dni);
                      setState(() {});
                    },
                    child: Text('Modificar Docente'))),
          ],
        ),
      ),
    );
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
              // keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              controller: widget._nombreDocente,
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

  Widget _inputDNI() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 60.0),
            child: Text(
              'DNI: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              controller: widget._dni,
              //keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _dni = valor;
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
              controller: widget._apellidoDocente,
              //keyboardType: TextInputType.number,
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

  Widget _inputRol() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 70.0),
            child: Text(
              'Rol: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              controller: widget._rolDocente,
              enabled: false,
              //  keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _rol = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  _checkRoles() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blueAccent)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Tutor',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 100.0),
                    child: Checkbox(
                      value: widget.tutor,
                      onChanged: (valor) {
                        setState(() {
                          widget.tutor = valor;
                          if (widget.tutor) {
                            widget._rolDocente.text = 'Tutor';
                            widget.jefatura = false;
                            widget.admin = false;
                            widget.profesor = false;
                          } else {
                            widget._rolDocente.text = '';
                            widget._claseTDocente.text = '';
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Profesor',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 80.0),
                    child: Checkbox(
                      value: widget.profesor,
                      onChanged: (valor) {
                        setState(() {
                          widget.profesor = valor;
                          if (widget.profesor) {
                            widget._rolDocente.text = 'Profesor';
                            widget.jefatura = false;
                            widget.admin = false;
                            widget.tutor = false;
                            widget._claseTDocente.text = '';
                          } else {
                            widget._rolDocente.text = '';
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Jefatura',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 82.0),
                    child: Checkbox(
                      value: widget.jefatura,
                      onChanged: (valor) {
                        setState(() {
                          widget.jefatura = valor;
                          if (widget.jefatura) {
                            widget._rolDocente.text = 'Jefatura';
                            widget.tutor = false;
                            widget.admin = false;
                            widget.profesor = false;
                            widget._claseTDocente.text = '';
                          } else {
                            widget._rolDocente.text = '';
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Admin',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 95.0),
                    child: Checkbox(
                      value: widget.admin,
                      onChanged: (valor) {
                        setState(() {
                          widget.admin = valor;
                          if (widget.admin) {
                            widget._rolDocente.text = 'Admin';
                            widget.jefatura = false;
                            widget.tutor = false;
                            widget.profesor = false;
                            widget._claseTDocente.text = '';
                          } else {
                            widget._rolDocente.text = '';
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _inputTurotia() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Text(
              'Clase a la que tutela: ',
              style: u.estilotexto,
            ),
          ),
          Flexible(
            child: TextField(
              controller: widget._claseTDocente,
              enabled: widget.tutor,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onChanged: (valor) {
                setState(() {
                  _claseT = valor;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget crearDropDownDocente() {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          Text(
            'DNI: ',
            style: u.estilotexto,
          ),
          Container(
            margin: EdgeInsets.only(left: 65.0),
            child: DropdownButton(
              value: widget._dnis[i],
              items: _getOpcionesNiasDropDown(widget._dnis),
              onChanged: (opt) async {
                i = 0;
                for (int x = 0; x < widget._dnis.length; x++) {
                  if (opt == widget._dnis[x]) {
                    i = x;
                  }
                }
                _dniv = widget._dnis[i];
                _dni = widget._dnis[i];
                _name = await c.obtenerNombrePrimerDocente(widget._dnis[i]);
                _subname =
                    await c.obtenerApellidoPrimerDocente(widget._dnis[i]);
                widget.tutor =
                    await c.obtenerTutorPrimerDocente(widget._dnis[i], 'Tutor');
                widget.admin =
                    await c.obtenerTutorPrimerDocente(widget._dnis[i], 'Admin');
                widget.jefatura = await c.obtenerTutorPrimerDocente(
                    widget._dnis[i], 'Jefatura');
                widget.profesor = await c.obtenerTutorPrimerDocente(
                    widget._dnis[i], 'Profesor');
                _claseT = await c.obtenerClaseDocente(_dni, widget.tutor);
                if (widget.tutor) _rol = 'Tutor';
                if (widget.jefatura) _rol = 'Jefatura';
                if (widget.admin) _rol = 'Admin';
                if (widget.profesor) _rol = 'Profesor';

                widget._rolDocente.text = _rol;
                widget._nombreDocente.text = _name;
                widget._apellidoDocente.text = _subname;
                widget._dni.text = _dni;
                widget._claseTDocente.text = _claseT;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _getOpcionesNiasDropDown(
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
              if (widget.tutor) {
                _optSelec = opt;
                widget._claseTDocente.text = _optSelec;
              }

              setState(() {});
            },
          ),
        ),
      ],
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
}
