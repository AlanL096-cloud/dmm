import 'package:appbd/src/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

void bd() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
}

class _RegistroPageState extends State<RegistroPage> {
// Mandar llamar bd

  var defaultText = TextStyle(color: Colors.black);
  var linkText = TextStyle(color: Colors.blue);
  FocusNode nombreFocus;
  FocusNode correoFocus;
  FocusNode passwordFocus;
  FocusNode direcFocus;
  FocusNode cpFocus;

  String nombre;
  String correo;
  String password;
  String direc;
  String cp;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Regisro'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    // CONTAINER NOBRE
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Nombre suario',
                          hintText: 'Benito Juarez',
                          prefixIcon: Icon(Icons.account_circle_outlined)),
                      //controller: nombreTextController,
                      onSaved: (value) {
                        nombre = value;
                      },
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        }
                      },
                      focusNode: this.nombreFocus,
                      onEditingComplete: () =>
                          requestFocus(context, nombreFocus),
                      textInputAction: TextInputAction.next,
                    ),
                  ), // CONTAINER NOMBRE
                ),
                SizedBox(
                  height: 6.0,
                ),
                Container(
                  // CONTINER CORREO
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Correo',
                        hintText: 'ejemplo@gmail.com',
                        prefixIcon: Icon(Icons.mail_outline)),
                    //controller: nombreTextController,
                    onSaved: (value) {
                      correo = value;
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Camp obligatorio';
                      }
                    },
                    focusNode: this.correoFocus,
                    onEditingComplete: () => requestFocus(context, correoFocus),
                    textInputAction: TextInputAction.next,
                  ),
                ), // CONTAINER CORREO
                SizedBox(
                  height: 6.0,
                ),
                //CONTAINER PASSWORD
                Container(
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Contraseña',
                        hintText: 'ABC123@',
                        prefixIcon: Icon(Icons.lock_outline)),
                    //controller: nombreTextController,
                    onSaved: (value) {
                      password = value;
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo obligatorio';
                      }
                    },
                    focusNode: this.passwordFocus,
                    onEditingComplete: () =>
                        requestFocus(context, passwordFocus),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                //CONTAINER PASSWORD
                SizedBox(
                  height: 6.0,
                ),
                //CONTAINER DIRECCIÓN
                Container(
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Dirección',
                        hintText: 'Cubilete no.24, Jacarandas de Banthí',
                        prefixIcon: Icon(Icons.house_outlined)),
                    //controller: nombreTextController,
                    onSaved: (value) {
                      direc = value;
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo obligatorio';
                      }
                    },
                    focusNode: this.direcFocus,
                    onEditingComplete: () => requestFocus(context, direcFocus),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                //CONTAINER DIRECCION
                SizedBox(
                  height: 6.0,
                ),
                //CONTAINER CP
                Container(
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Código Postal',
                        hintText: '76805',
                        prefixIcon: Icon(Icons.map_outlined)),
                    //controller: nombreTextController,
                    onSaved: (value) {
                      cp = value;
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo obligatorio';
                      }
                    },
                    focusNode: this.cpFocus,
                    onEditingComplete: () => requestFocus(context, cpFocus),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                //CONTAINER CP
                SizedBox(
                  height: 6.0,
                ),

                SizedBox(
                  width: 150,
                  height: 50,
                  child: Container(
                    child: Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (bool value) {
                            print(value);
                          },
                        ),
                        Text('Recuérdame'),
                      ],
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      Map<String, dynamic> data = {
                        "nombre": this.nombre,
                        "correo": this.correo,
                        "password": this.password,
                        "direc": this.direc,
                        "cp": this.cp
                      };
                      FirebaseFirestore.instance
                          .collection("usuario")
                          .add(data);
                    }
                  },
                  child: Text('Registrarme'),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FormPage()));
                  },
                  child: Text('Loggin'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus();
  }

  @override
  void initState() {
    super.initState();
    nombreFocus = FocusNode();
    correoFocus = FocusNode();
    passwordFocus = FocusNode();
    direcFocus = FocusNode();
    cpFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    nombreFocus.dispose();
    correoFocus.dispose();
    passwordFocus.dispose();
    direcFocus.dispose();
    cpFocus.dispose();
  }
}

class Argumentos {
  String nombre;
  String correo;
  String password;

  Argumentos({this.nombre, this.correo, this.password});
}
