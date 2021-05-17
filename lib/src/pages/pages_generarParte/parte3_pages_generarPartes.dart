import 'package:flutter/material.dart';
import 'package:gestor_partes/src/controlador/parte.dart';
import 'package:gestor_partes/src/controlador/tipificacion.dart';
import 'package:gestor_partes/src/controlador/utiles_controlador.dart';
import 'package:gestor_partes/src/widgets/botones_widgets.dart';

// ignore: must_be_immutable
class Partepage3 extends StatefulWidget {
  String dni;
  List<Tipificacion> listaTipificaciones = [];
  Parte parte = Parte();
  Partepage3(this.dni, this.listaTipificaciones, this.parte);
  @override
  _Partepage3State createState() => _Partepage3State();
}

class _Partepage3State extends State<Partepage3> {
  Utiles u = Utiles();
  BotonesWidgets btn = BotonesWidgets();

  String _comTel;

  bool medidaEducativa1 = false,
      medidaEducativa2 = false,
      medidaEducativa3 = false,
      medidaEducativa4 = false,
      medidaEducativa5 = false,
      medidaEducativa6 = false,
      medidaEducativa7 = false,
      medidaEducativa8 = false;
  String _fecha = '';
  TextEditingController _inputFieldObservacionTelefonicaDateController =
      TextEditingController();
  //TextEditingController _inputFieldM1Controller = TextEditingController();
  TextEditingController _inputFieldM2FI = TextEditingController();
  TextEditingController _inputFieldM3FI = TextEditingController();
  TextEditingController _inputFieldM4FI = TextEditingController();
  TextEditingController _inputFieldM5FI = TextEditingController();
  TextEditingController _inputFieldM6FI = TextEditingController();
  TextEditingController _inputFieldM7FI = TextEditingController();
  TextEditingController _inputFieldM8FI = TextEditingController();

  TextEditingController _inputFieldM2FF = TextEditingController();
  TextEditingController _inputFieldM3FF = TextEditingController();
  TextEditingController _inputFieldM4FF = TextEditingController();
  TextEditingController _inputFieldM5FF = TextEditingController();
  TextEditingController _inputFieldM6FF = TextEditingController();
  TextEditingController _inputFieldM7FF = TextEditingController();
  TextEditingController _inputFieldM8FF = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gestión Partes 3'),
          centerTitle: true,
        ),
        body: Container(
          /*  decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.blueAccent)), */
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: ListView(
            //physics: const NeverScrollableScrollPhysics(),
            children: [
              _crearCheckBox1(),
              _crearCheckBox2(),
              _crearCheckBox3(),
              _crearCheckBox4(),
              _crearCheckBox5(),
              _crearCheckBox6(),
              _crearCheckBox7(),
              _crearCheckBox8(),
              _comunicacionTele(_inputFieldObservacionTelefonicaDateController),
              btn.btnInsertarParte(
                  context,
                  widget.dni,
                  widget.parte,
                  _comTel,
                  _fecha,
                  widget.listaTipificaciones,
                  medidaEducativa1,
                  medidaEducativa2,
                  medidaEducativa3,
                  medidaEducativa4,
                  medidaEducativa5,
                  medidaEducativa6,
                  medidaEducativa7,
                  medidaEducativa8,
                  _inputFieldM2FI.text,
                  _inputFieldM2FF.text,
                  _inputFieldM3FI.text,
                  _inputFieldM3FF.text,
                  _inputFieldM4FI.text,
                  _inputFieldM4FF.text,
                  _inputFieldM5FI.text,
                  _inputFieldM5FF.text,
                  _inputFieldM6FI.text,
                  _inputFieldM6FF.text,
                  _inputFieldM7FI.text,
                  _inputFieldM7FF.text,
                  _inputFieldM8FI.text,
                  _inputFieldM8FF.text),
            ],
          ),
        ));
  }

  _crearCheckBox1() {
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
                    'Derivación a jefatura de estudios',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 80.0),
                    child: Checkbox(
                      value: medidaEducativa1,
                      onChanged: (valor) {
                        setState(() {
                          medidaEducativa1 = valor;
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

  _crearCheckBox2() {
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
                    'Privación del periodo de patio',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 100.0),
                    child: Checkbox(
                      value: medidaEducativa2,
                      onChanged: (valor) {
                        setState(() {
                          medidaEducativa2 = valor;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.8),
                    child: Container(
                      //padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: _crearFecha(
                          context, _inputFieldM2FI, medidaEducativa2, 'Fini'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.5),
                      child: _crearFecha(
                          context, _inputFieldM2FF, medidaEducativa2, 'Ffin'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  _crearCheckBox3() {
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
                    'Realizar trabajos fuera de horario',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 80.0),
                    child: Checkbox(
                      value: medidaEducativa3,
                      onChanged: (valor) {
                        setState(() {
                          medidaEducativa3 = valor;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.8),
                    child: Container(
                      //padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: _crearFecha(
                          context, _inputFieldM3FI, medidaEducativa3, 'Fini'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.5),
                      child: _crearFecha(
                          context, _inputFieldM3FF, medidaEducativa3, 'Ffin'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  _crearCheckBox4() {
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
                    'Retirada de dispositivo',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 150.0),
                    child: Checkbox(
                      value: medidaEducativa4,
                      onChanged: (valor) {
                        setState(() {
                          medidaEducativa4 = valor;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.8),
                    child: Container(
                      //padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: _crearFecha(
                          context, _inputFieldM4FI, medidaEducativa4, 'Fini'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.5),
                      child: _crearFecha(
                          context, _inputFieldM4FF, medidaEducativa4, 'Ffin'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  _crearCheckBox5() {
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
                    'Suspensión de actividades extraescolares',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Checkbox(
                      value: medidaEducativa5,
                      onChanged: (valor) {
                        setState(() {
                          medidaEducativa5 = valor;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.8),
                    child: Container(
                      //padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: _crearFecha(
                          context, _inputFieldM5FI, medidaEducativa5, 'Fini'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.5),
                      child: _crearFecha(
                          context, _inputFieldM5FF, medidaEducativa5, 'Ffin'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  _crearCheckBox6() {
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
                    'Suspensión de asistencia a clase',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 80.0),
                    child: Checkbox(
                      value: medidaEducativa6,
                      onChanged: (valor) {
                        setState(() {
                          medidaEducativa6 = valor;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.8),
                    child: Container(
                      //padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: _crearFecha(
                          context, _inputFieldM6FI, medidaEducativa6, 'Fini'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.5),
                      child: _crearFecha(
                          context, _inputFieldM6FF, medidaEducativa6, 'Ffin'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  _crearCheckBox7() {
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
                    'Incorporación al aula de convivencia',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 60.0),
                    child: Checkbox(
                      value: medidaEducativa7,
                      onChanged: (valor) {
                        setState(() {
                          medidaEducativa7 = valor;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.8),
                    child: Container(
                      //padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: _crearFecha(
                          context, _inputFieldM7FI, medidaEducativa7, 'Fini'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.5),
                      child: _crearFecha(
                          context, _inputFieldM7FF, medidaEducativa7, 'Ffin'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  _crearCheckBox8() {
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
                    'Asistencia a otras clases',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 130.0),
                    child: Checkbox(
                      value: medidaEducativa8,
                      onChanged: (valor) {
                        setState(() {
                          medidaEducativa8 = valor;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.8),
                    child: Container(
                      //padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: _crearFecha(
                          context, _inputFieldM8FI, medidaEducativa8, 'Fini'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.5),
                      child: _crearFecha(
                          context, _inputFieldM8FF, medidaEducativa8, 'Ffin'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _comunicacionTele(TextEditingController txe) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.blueAccent)),
      child: Column(
        children: [
          Text('Comunicación Telefónica'),
          TextField(
            maxLines: 2,
            onChanged: (value) {
              setState(() {
                _comTel = value;
              });
            },
            decoration: InputDecoration(
                labelText: 'Observaciones',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          ),
          _crearFecha(context, txe, true, 'Fecha')
        ],
      ),
    );
  }

  _selectDate(BuildContext context, TextEditingController txe) async {
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
        txe.text = _fecha;
      });
    }
  }

  Widget _crearFecha(
      BuildContext context, TextEditingController txe, bool hab, String texto) {
    if (hab) {
      return fechaHabilitada(
          context, txe, hab, texto, u.estilotextohabilitado, u.iconohabilitado);
    } else {
      return fechaHabilitada(context, txe, hab, texto,
          u.estilotextodeshabilitado, u.iconodeshabilitado);
    }
  }

  Widget fechaHabilitada(BuildContext context, TextEditingController txe,
      bool hab, String texto, TextStyle estilo, Color colorIcono) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 5.0),
            child: Text(
              texto,
              style: estilo,
            ),
          ),
          Flexible(
            child: TextField(
              enableInteractiveSelection: false,
              enabled: hab,
              controller: txe,
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.calendar_today_outlined,
                    color: colorIcono,
                    size: 20.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectDate(context, txe);
              },
            ),
          ),
        ],
      ),
    );
  }
}
