import 'package:flutter/material.dart';

import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import 'bdDeleteAlumnos_utiles_page.dart';
import 'bdInsertAlumnos_utiles_page.dart';
import 'bdUpdateAlumnos_utiles_page.dart';

// ignore: must_be_immutable
class BDGestionAlumnos extends StatefulWidget {
  List<String> nias = [];
  TextEditingController nombreAlumno = TextEditingController();
  TextEditingController apellidoAlumno = TextEditingController();
  TextEditingController cursoAlumno = TextEditingController();
  TextEditingController niaAlumno = TextEditingController();

  BDGestionAlumnos(this.nias, this.nombreAlumno, this.apellidoAlumno,
      this.cursoAlumno, this.niaAlumno);
  @override
  _BDGestionAlumnosState createState() => _BDGestionAlumnosState();
}

class _BDGestionAlumnosState extends State<BDGestionAlumnos> {
  List<ScreenHiddenDrawer> items = [];

  @override
  void initState() {
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Insert Alumno",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        InsertPageAlumnos()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Delete Alumno",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        DeletePageAlumnos()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Update Alumno",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        UpdatePageAlumnos(widget.nias, widget.nombreAlumno,
            widget.apellidoAlumno, widget.cursoAlumno, widget.niaAlumno)));

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
