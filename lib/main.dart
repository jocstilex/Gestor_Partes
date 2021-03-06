import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestor_partes/src/routes/rutas_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getAplicationRoutes(),
      theme: ThemeData(),
    );
  }
}
