import 'package:appbd/src/registro_page.dart';
import 'package:flutter/material.dart';

import '../main.dart';

Map<String, WidgetBuilder> obtenerRutas() {
  return <String, WidgetBuilder>{
    //  '/': (BuildContext context) => FormPage(),
    // 'mapa': (BuildContext context) => MapaPage(),
    'login': (BuildContext context) => MyHomePage(),
    'registro': (BuildContext context) => RegistroPage(),
  };
}
