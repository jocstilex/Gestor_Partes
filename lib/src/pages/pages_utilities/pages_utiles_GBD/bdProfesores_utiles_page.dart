import 'package:flutter/material.dart';

import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import 'bdDeleteDocente_utiles_page.dart';
import 'bdInsertDocente_utiles_page.dart';
import 'bdUpdateDocente_utiles_page.dart';

// ignore: must_be_immutable
class BDGestionProfesores extends StatefulWidget {
  bool tutoria;
  bool jefatura;
  bool profesor;
  bool admin;
  List<String> dnis = [];
  TextEditingController nombreDocente = TextEditingController();
  TextEditingController apellidoDocente = TextEditingController();
  TextEditingController rolDocente = TextEditingController();

  TextEditingController dniDocente = TextEditingController();

  BDGestionProfesores(
      this.dnis,
      this.nombreDocente,
      this.apellidoDocente,
      this.rolDocente,
      this.tutoria,
      this.jefatura,
      this.admin,
      this.profesor,
      this.dniDocente);
  @override
  _BDGestionProfesoresState createState() => _BDGestionProfesoresState();
}

class _BDGestionProfesoresState extends State<BDGestionProfesores> {
  List<ScreenHiddenDrawer> items = [];

  @override
  void initState() {
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Insert Docentes",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        InsertPageDocentes()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Delete Docentes",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        DeletePageDocentes()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Update Docentes",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        UpdatePageDocentes(
            widget.dnis,
            widget.dniDocente,
            widget.nombreDocente,
            widget.apellidoDocente,
            widget.rolDocente,
            widget.tutoria,
            widget.jefatura,
            widget.admin,
            widget.profesor)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.cyan,
      backgroundColorAppBar: Colors.blue,
      screens: items,
      //    typeOpen: TypeOpen.FROM_RIGHT,
      //    disableAppBarDefault: false,
      //    enableScaleAnimin: true,
      //    enableCornerAnimin: true,
      slidePercent: 70.0,
      verticalScalePercent: 80.0,
      contentCornerRadius: 40.0,
      //    iconMenuAppBar: Icon(Icons.menu),
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      //    whithAutoTittleName: true,
      //    styleAutoTittleName: TextStyle(color: Colors.red),
      //    actionsAppBar: <Widget>[],
      //    backgroundColorContent: Colors.blue,
      //    elevationAppBar: 4.0,
      //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
      //    enableShadowItensMenu: true,
      //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );
  }
}
