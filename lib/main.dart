import 'package:appbd/src/registro_page.dart';
import 'package:appbd/src/secondFormPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

import 'models/data_models.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
  //Firebase
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'Pruba Firebase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var defaultText = TextStyle(color: Colors.black);
  var linkText = TextStyle(color: Colors.blue);
  FocusNode nombreFocus;
  FocusNode correoFocus;
  FocusNode passwordFocus;

  String nombre;
  String correo;
  String password;
  String error = ('');

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ALVALI'),
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
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'nombre usuario',
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
                          requestFocus(context, correoFocus),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Container(
                  width: 300,
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'correo',
                          hintText: 'Ejemplo@example.com',
                          prefixIcon: Icon(Icons.mail_outline)),
                      //controller: apTextController,
                      onSaved: (value) {
                        correo = value;
                      },
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        }
                      },
                      focusNode: this.passwordFocus,
                      onEditingComplete: () =>
                          requestFocus(context, correoFocus),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'contraseña',
                          hintText: 'AbC123@',
                          prefixIcon: Icon(Icons.lock_outline)),
                      //controller: apTextController,
                      onSaved: (value) {
                        password = value;
                      },
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        }
                      }),
                ),
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
                        Text('recuerdame'),
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
                      FirebaseFirestore.instance
                          .collection('usuario')
                          .where('nombre', isEqualTo: this.nombre)
                          .where('password', isEqualTo: this.password)
                          .snapshots()
                          .listen((event) {
                        event.docs.forEach((element) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondFormPage()));
                        });
                      });
                    } else {
                      print(error);
                      error = ('datos incorrectos');
                    }
                  },
                  child: Text('INGRESAR'),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistroPage()));
                  },
                  child: Text('Registarme'),
                ),
                SizedBox(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(style: defaultText, text: error),
                  ])),
                )
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
    //nombreTextController = TextEditingController();
    //apTextController = TextEditingController();
    nombreFocus = FocusNode();
    correoFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    //nombreTextController.dispose();
    //apTextController.dispose();
    nombreFocus.dispose();
    correoFocus.dispose();
    passwordFocus.dispose();
  }
}

class Argumentos {
  String nombre;
  String email;
  String password;

  Argumentos({this.nombre, this.email, this.password});
}

/*
FocusNode passwordFocus;
FocusNode nombreFocus;

void validarFirebase() {
  FirebaseFirestore.instance
      .collection('usuario')
      .where('nombre', isEqualTo: nombreFocus)
      .where('password', isEqualTo: passwordFocus)
      .snapshots()
      .listen((event) {
    event.docs.forEach((element) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FormPage()));
    });
  });
}
*/
